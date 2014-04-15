class SubmissionsMailer < ActionMailer::Base
  default from: "noreply@ada.cs.ship.edu"
  layout 'mail'

  def today(submissions)
    @submissions = submissions
    @date = DateTime.now.to_date

    # do color highlighting on each submission row
    @color_mapping = Submission::Colorer.new(@submissions).color

    mail to: 'ada@cs.ship.edu', subject: "Today's Exams (#{@date})"
  end
end
