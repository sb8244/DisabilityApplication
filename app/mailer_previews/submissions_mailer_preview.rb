class SubmissionsMailerPreview
  def today
    SubmissionsMailer.today Submission.today
  end

  def reminder
    SubmissionsMailer.reminder Submission.first
  end
end
