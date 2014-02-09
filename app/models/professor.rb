class Professor < ActiveRecord::Base
  has_many :submissions

  before_save { self.email = email.downcase }

  # Does this introduce a sql injection issue because email/name wrapped in a string?
  scope :like_email, ->(email) { where("email LIKE ?", "%#{email}%") }
  scope :like_name,  ->(name)  { where("name LIKE ?", "%#{name}%") }

  validates :name, presence: true 
  validates :email, presence: true, 
            :email_format => {:message => 'is not an email'},
            uniqueness: { case_sensitive: false }
end