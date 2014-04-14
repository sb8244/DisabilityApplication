class ConfirmationMailer < ActionMailer::Base
  default from: "noreply@ada.cs.ship.edu"
  layout 'mail'

  def do_mail(submission_id)
    @submission = get_submission(submission_id)
    @submission.mail_records.create(date: DateTime.now, to: @submission.student_email)
    @submission.mail_records.create(date: DateTime.now, to: @submission.professor.email)

    mail to: [@submission.student_email, @submission.professor.email], bcc: ['ada@cs.ship.edu'], subject: "Exam Scheduled"
  end

  def get_submission(id)
    Submission.find(id)
  end
end