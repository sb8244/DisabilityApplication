class ConfirmationMailerPreview
  def do_mail
    ConfirmationMailer.do_mail(Submission.first.id)
  end
end
