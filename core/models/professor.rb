require "validates_email_format_of"

class Professor
  include AttributeAssignment
  include ActiveModel::Validations

  attr_accessor :name, :email

  def initialize(attributes = {})
    assign_attributes(attributes)
  end

  private

  validates :name, presence: true
  validates :email, presence: true,
            email_format: { message: 'is not an email' }
end
