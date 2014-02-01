class Submission < ActiveRecord::Base

  validate :start_time_is_valid_datetime?

  validates :student_name, presence: true
  validates :student_email, presence: true
  validates :course_number, presence: true

  private
    def start_time_is_valid_datetime?
      unless start_time.is_a?(ActiveSupport::TimeWithZone)
        errors.add(:start_time, "must be a valid datetime")
      end
    end

end
