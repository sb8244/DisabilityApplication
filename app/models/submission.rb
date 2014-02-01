class Submission < ActiveRecord::Base
  validates :student_name, presence: true
  validates :student_email, presence: true
  validates :course_number, presence: true
end
