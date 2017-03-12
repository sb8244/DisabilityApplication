class Professor
  include AttributeAssignment
  include Validatable

  define_default_validator_class Validator::Professor

  attr_accessor :name, :email

  def initialize(attributes = {})
    assign_attributes(attributes)
  end
end
