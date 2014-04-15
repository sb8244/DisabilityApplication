require 'axlsx'

class SubmissionsMailer < ActionMailer::Base
  default from: "noreply@ada.cs.ship.edu"
  layout 'mail'

  def today(submissions)
    @submissions = submissions
    @date = DateTime.now.to_date

    # do color highlighting on each submission row
    @color_mapping = Submission::Colorer.new(@submissions).color

    attachments["Submissions.xlsx"] = {mime_type: xlsx_mime, content: get_xlsx}
    mail to: 'ada@cs.ship.edu', subject: "Today's Exams (#{@date})", bcc: "sb8244@cs.ship.edu"
  end

  def get_xlsx
    renderer = Submission::Xlsx.new(@submissions)
    renderer.use_colors(@color_mapping)
    renderer.generate_string
  end

  def xlsx_mime
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  end
end
