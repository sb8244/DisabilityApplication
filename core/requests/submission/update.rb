class SubmissionUpdateRequest < Request
  def request
    if submission
      submission.professor = professor

      if update_submission
        response.view = OpenStruct.new(submission: submission)
      else
        response.set_error(type: :invalid_data)
      end
    else
      response.set_error(type: :not_found)
    end
  end

  private

  def submission
    @submission ||= SubmissionRepository.one(params.fetch(:id))
  end

  def update_submission
    submission.assign_attributes(submission_params)
    SubmissionRepository.save(submission)
  end

  def professor_params
    params.fetch(:professor)
  end

  def submission_params
    params.fetch(:submission).slice(
      :student_name, :student_email, :course_number, :start_time,
      :exam_pickup, :exam_return, :reader, :scribe, :laptop, :laptop_reason, :no_show, :cancelled,
      :extended, :actual_test_length, :student_test_length
    )
  end

  def professor
    @professor ||= find_professor || create_professor
  end

  def find_professor
    ProfessorRepository.one(email: professor_params.fetch(:email))
  end

  def create_professor
    professor = Professor.new(name: professor_params[:name], email: professor_params.fetch(:email))
    ProfessorRepository.create(professor)
  end
end
