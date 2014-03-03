class SubmissionsMailerPreview
  def today
    SubmissionsMailer.today submissions
  end

  private
    def submissions
      Submission.today
    end
end
