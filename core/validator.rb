require "validates_email_format_of"

class Validator
  include ActiveModel::Validations

  def initialize(base)
    @base = base
  end

  def method_missing(*args)
    @base.send(*args)
  end
end

require_relative "./validator/type_of_validator"
require_relative "./validator/professor"
require_relative "./validator/submission"
require_relative "./validator/submission_mailing"
