class SubmissionsMailer < ActionMailer::Base
  default from: "noreply@disabilityapp.com"

  def today(submissions)
    @submissions = submissions
    @date = DateTime.now.to_date
    mail to: 'sb8244@cs.ship.edu', subject: "Today's Exams (#{@date})"
  end
end
