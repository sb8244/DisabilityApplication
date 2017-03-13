class SubmissionMailing
  include AttributeAssignment
  include Validatable

  define_default_validator_class Validator::SubmissionMailing

  attr_accessor :submission, :date, :to

  def initialize(attributes = {})
    assign_attributes(attributes)
  end
end
