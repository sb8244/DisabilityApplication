class Professor < ActiveRecord::Base
  has_many :submissions
  
  before_save { self.email = email.downcase }

  validates :name, presence: true 
  validates :email, presence: true, 
            :email_format => {:message => 'is not an email'},
            uniqueness: { case_sensitive: false }
end
