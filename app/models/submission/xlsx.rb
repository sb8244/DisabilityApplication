class Submission::Xlsx

  def initialize(submissions)
    @submissions = submissions
    @color_mapping = nil
  end

  def use_colors(mapping)
    @color_mapping = mapping
  end

  def map_styles(wb)
    if @color_mapping
      @style_mapping = {}
      @color_mapping.each do |k, v|
        @style_mapping[k] = wb.styles.add_style(bg_color: "00#{v.delete('#')}")
      end
    end
  end

  def generate_string
    p = Axlsx::Package.new
    wb = p.workbook
    map_styles(wb)
    wb.add_worksheet(name: "Scheduled Exams") do |sheet|
      sheet.add_row header_row
      @submissions.each do |submission|
        if @style_mapping && @style_mapping.has_key?(submission)
          sheet.add_row(submission_row(submission), style: @style_mapping[submission])
        else
          sheet.add_row(submission_row(submission))
        end
      end
    end

    # Package to StringIO to string conversion
    p.to_stream.read
  end

  def header_row
    ["Date", "Start", "Finish", "Laptop", "R-S", "Student Name", "Student Email", "Exam Return",
     "Exam Pickup", "Professor Name", "Professor Email", "Class Length", "Course", "Test"]
  end

  def submission_row(submission)
    row = []
    Submission::Renderer.render(submission) do |value|
      row << value
    end
  end
end