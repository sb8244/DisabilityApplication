class Validator::Professor < Validator
  validates :name, presence: true
  validates :email, presence: true,
                    email_format: { message: 'is not an email' }
end
