class Submission::SemesterReportXlsx

  def initialize(semester_report:, finals_report:, semester_subtotal:, finals_subtotal:)
    @semester_report = semester_report
    @finals_report = finals_report
    @semester_subtotal = semester_subtotal
    @finals_subtotal = finals_subtotal
    @grand_total = @semester_subtotal.merge(@finals_subtotal){ |key, old, new| old + new }
  end

  def map_styles(wb)
    @style_mapping = {}
    color_mapping.each do |k, v|
      @style_mapping[k] = wb.styles.add_style(bg_color: "00#{v.delete('#')}")
    end
  end

  def generate
    p = Axlsx::Package.new
    wb = p.workbook
    map_styles(wb)
    wb.add_worksheet(name: "Test Breakdown") do |sheet|
      sheet.add_row(header_row)

      @semester_report.each do |date, item|
        sheet.add_row(report_row(date, item))
      end

      sheet.add_row(report_row('SUB-TOTALS', @semester_subtotal), style: @style_mapping[:blue])

      sheet.add_row(header_row)

      @finals_report.each do |date, item|
        sheet.add_row(report_row(date, item))
      end
      sheet.add_row(report_row('FINALS SUB-TOTALS', @finals_subtotal), style: @style_mapping[:blue])
      sheet.add_row(report_row('GRAND TOTAL', @grand_total), style: @style_mapping[:green])
    end

    # Package to StringIO to string conversion
    p.to_stream.read
  end

  private

  def header_row
    ["Date", "R & S", "L & S", "Reader", "Scribe", "Laptop", "Extended Time",
     "Regular", "* No Show", "* Cancelled", "# Tests Given"]
  end

  def color_mapping
    { blue: '#d9edf7', green: '#dff0d8' }
  end

  def report_row(date, item)
    [ date, item[:reader_scribe], item[:laptop_scribe], item[:reader], item[:scribe],
     item[:laptop], item[:extended], item[:regular], item[:no_show], item[:cancelled], item[:total] ]
  end
end
