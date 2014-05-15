class Submission::Renderer

  # Yield values for a submission so that they can be formatted in a block
  # This will allow a consistent table pattern throughout the application that is DRY
  def self.render(submission)
    yield submission.start_time.to_formatted_s(:date)
    yield submission.start_time.to_formatted_s(:time)
    yield submission.end_time.to_formatted_s(:time)
    yield laptop(submission)
    yield r_s(submission)
    yield submission.student_name
    yield submission.student_email
    yield submission.exam_return
    yield submission.exam_pickup
    yield submission.professor.name
    yield submission.professor.email
    yield submission.student_test_length
    yield submission.course_number
  end

  def self.laptop(submission)
    if submission.laptop
      if submission.laptop_reason.blank?
        if submission.scribe
          return "S/L"
        else
          return "L"
        end
      else
        return submission.laptop_reason
      end
    end
    ""
  end

  def self.r_s(submission)
    if submission.reader && submission.scribe
      return "R-S"
    elsif submission.reader
      return "R"
    elsif submission.scribe
      return "S"
    end
  end
end
