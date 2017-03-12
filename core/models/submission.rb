class Submission
  include AttributeAssignment
  include Validatible

  define_default_validator_class Validator::Submission

  attr_accessor :student_name, :student_email, :course_number, :start_time, :actual_test_length,
                :student_test_length, :exam_pickup, :exam_return, :reader, :laptop, :scribe, :professor

  def initialize(attributes = {})
    assign_attributes(attributes)
  end

  def start_time_formatted
    start_time.present? ? start_time.to_formatted_s(:long_ordinal) : ""
  end

  def end_time
    start_time.present? ? start_time + student_test_length.minutes : nil
  end
end
