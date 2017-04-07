class SubmissionShowRequest < Request
  def request
    authorized!

    if submission
      response.view = OpenStruct.new(submission: submission)
    else
      response.set_error(type: :not_found)
    end
  end

  private

  def submission
    @submission ||= SubmissionRepository.one(params.fetch(:id))
  end
end
