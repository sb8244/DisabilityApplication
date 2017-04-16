module Validatable
  def self.included(base)
    base.extend(ClassMethods)
  end

  def validator
    @validator ||= self.class.default_validator_class.new(self)
  end

  def validator=(validator)
    @validator = validator
  end

  def valid?
    validator.valid?
  end

  def errors
    validator.errors
  end

  def full_error_messages
    errors.full_messages
  end

  module ClassMethods
    def define_default_validator_class(klass)
      @default_validator_class = klass
    end

    def default_validator_class
      @default_validator_class
    end
  end
end
