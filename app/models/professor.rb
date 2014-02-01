class Professor < ActiveRecord::Base
  validates( :name, presence: true )
end
