class ConfirmationMailer < ActionMailer::Base
  default from: "noreply@ada.cs.ship.edu"
  layout 'mail'

  def do_mail(submission_id)
    @submission = Submission.find(submission_id)
    mail to: [@submission.student_email, @submission.professor.email], bcc: ['ada@cs.ship.edu'], subject: "Today's Exams (#{@date})"
  end
end