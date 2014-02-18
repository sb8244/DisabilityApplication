class Submission < ActiveRecord::Base
  belongs_to :professor

  validate :start_time_is_valid_datetime?
  validates :student_name, presence: true
  validates :student_email, presence: true
  validates :course_number, presence: true
  validates :class_length, numericality: true
  validates :exam_pickup, presence: true
  validates :exam_return, presence: true
  validates :reader, :inclusion => {:in => [true, false]}
  validates :scribe, :inclusion => {:in => [true, false]}
  validates :laptop, :inclusion => {:in => [true, false]}
  validates :professor, existence: true

  scope :find_in_date, -> (beginning, ending) { where(start_time: beginning..ending) }
  scope :today, -> { find_in_date(DateTime.now.beginning_of_day, DateTime.now.end_of_day) }
  
  private
    def start_time_is_valid_datetime?
      unless start_time.is_a?(ActiveSupport::TimeWithZone)
        errors.add(:start_time, "must be a valid datetime")
      end
    end
end