class SubmissionsMailer < ActionMailer::Base
  default from: "noreply@ada.cs.ship.edu"
  layout 'mail'

  def today(submissions)
    @submissions = submissions
    @date = DateTime.now.to_date
    mail to: 'ada@cs.ship.edu', subject: "Today's Exams (#{@date})"
  end
end
