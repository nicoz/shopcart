class SuperAdministrator
  include ActiveModel::Model
  attr_accessor :email, :password, :confirmation
  
  validates :email, presence: true
  validates :password, presence: true
  validates :confirmation, presence: true
  
end
