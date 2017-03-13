class Validator::SubmissionMailing < Validator
  validates :date, presence: true
  validates :submission, presence: true,
                         type_of: { klass_name: "Submission" }
  validates :to, presence: true
end
