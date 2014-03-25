#this class assist in creating the first user that will be used in the system
#it purpouse is to help separate the concepts of a normal user creation 
# that includes adding Roles to it, and other particular data, such as its name, etc.
class Session
  include ActiveModel::Model
  include ActiveModel::Serialization
  include ActiveModel::AttributeMethods
  include ActiveModel::Serialization
  
  attribute_method_affix  prefix: 'reset_', suffix: '_to_default!'
  attribute_method_suffix '_contrived?'
  attribute_method_prefix 'clear_'

  
  attr_accessor :attributes, :email, :password
  
  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true, length: { minimum: 8 }
 
  def initialize(attributes={})
    self.attributes = attributes
    self.email = self.attributes[:email] if self.attributes[:email]
    self.password = self.attributes[:password] if self.attributes[:password]
  end

end
