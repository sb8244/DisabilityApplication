class Validator::SubmissionMailing < Validator
  validates :date, presence: true
  validates :submission, presence: true
  validates :to, presence: true
end
