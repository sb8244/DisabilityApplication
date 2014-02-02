class Professor < ActiveRecord::Base
  has_many :submissions

  before_save { self.email = email.downcase }

  scope :like_email, ->(email) { where("email LIKE ?", "%#{email}%") }

  validates :name, presence: true 
  validates :email, presence: true, 
            :email_format => {:message => 'is not an email'},
            uniqueness: { case_sensitive: false }
end
