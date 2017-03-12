require "validates_email_format_of"

class Submission
  include AttributeAssignment
  include ActiveModel::Validations

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

  private

  validates :student_name, presence: true
  validates :student_email, presence: true,
            email_format: { message: 'is not an email' }
  validates :course_number, presence: true
  validates :exam_pickup, presence: true
  validates :exam_return, presence: true
  validates :actual_test_length, numericality: true
  validates :student_test_length, numericality: true
  validates :reader, inclusion: { in: [true, false] }
  validates :scribe, inclusion: { in: [true, false] }
  validates :laptop, inclusion: { in: [true, false] }
end
