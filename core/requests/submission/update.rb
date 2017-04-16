class SubmissionUpdateRequest < Request
  def request
    if submission
      submission.professor = professor
      update_submission
      response.view = OpenStruct.new(submission: submission)
    else
      response.set_error(type: :not_found)
    end
  rescue InvalidProfessorError => e
    response.set_error(type: :invalid_data, reason: "Professor is invalid")
    response.view = OpenStruct.new(errors: { professor: e.validation_errors })
  rescue InvalidSubmissionError => e
    response.set_error(type: :invalid_data, reason: "Submission is invalid")
    response.view = OpenStruct.new(errors: { submission: e.validation_errors })
  end

  private

  def submission
    @submission ||= SubmissionRepository.one(params.fetch(:id))
  end

  def update_submission
    submission.assign_attributes(submission_params)
    raise InvalidSubmissionError.new(submission.full_error_messages) unless submission.valid?
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
    return unless professor_params[:email].present?
    ProfessorRepository.one(email: professor_params.fetch(:email))
  end

  def create_professor
    professor = Professor.new(name: professor_params[:name], email: professor_params[:email])
    raise InvalidProfessorError.new(professor.full_error_messages) unless professor.valid?
    ProfessorRepository.create(professor)
  end

  class InvalidProfessorError < StandardError
    attr_reader :validation_errors

    def initialize(validation_errors)
      super("Professor is not valid #{validation_errors}")
      @validation_errors = validation_errors
    end
  end

  class InvalidSubmissionError < StandardError
    attr_reader :validation_errors

    def initialize(validation_errors)
      super("Submission is not valid #{validation_errors}")
      @validation_errors = validation_errors
    end
  end
end
