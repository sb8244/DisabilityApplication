class Validator::Submission < Validator
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
  validates :professor, presence: true,
                        type_of: { klass_name: "Professor" }
end
