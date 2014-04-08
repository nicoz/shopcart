#this class assist in creating the first user that will be used in the system
#it purpouse is to help separate the concepts of a normal user creation 
# that includes adding Roles to it, and other particular data, such as its name, etc.
class Session
  include ActiveModel::Model
  include ActiveModel::Serialization
  include ActiveModel::AttributeMethods
  include ActiveModel::Serialization
  include UsersHelper
  
  attribute_method_affix  prefix: 'reset_', suffix: '_to_default!'
  attribute_method_suffix '_contrived?'
  attribute_method_prefix 'clear_'

  
  attr_accessor :attributes, :email, :password, :social_id, :service_id, :name,
    :social_name, :social_token
  
  validates :email, presence: true, if: :web_user?
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, if: :web_user?
  validates :password, presence: true, length: { minimum: 8 }, if: :web_user?
 
  def initialize(attributes={})
    self.attributes = attributes
    self.email = self.attributes[:email] if self.attributes[:email]
    self.password = self.attributes[:password] if self.attributes[:password]


    self.social_id = self.attributes[:social_id] if self.attributes[:social_id]
    self.service_id = self.attributes[:service_id] if self.attributes[:service_id]
    
    self.name = self.attributes[:name] if self.attributes[:name]
    self.social_name = self.attributes[:social_name] if self.attributes[:social_name]
    self.social_token = self.attributes[:social_token] if self.attributes[:social_token]
  end
  
  def save
    return nil if !self.valid?
    
    if web_user?
      user = User.find_by(email: self.email.downcase)
      
      return nil if user.nil?
      
      return user.authenticate(self.password)
    else
      social_user = SocialUser.where(social_id: self.social_id, 
        service_id: self.service_id).first
        
      if social_user.nil?
        email = random_email
        password = random_password
        user = User.create(name: self.name, email: email, password: password,
          password_confirmation: password)
        unless user.nil?
          SocialUser.create(user_id: user.id, social_id: self.social_id,
           service_id: self.service_id, name: self.name, 
           social_name: self.social_name, social_token: self.social_token)
           return social_user
        end
      else
        social_user.update_attributes(social_token: self.social_token)
        return social_user
      end
      

    end
  end
  
  def web_user?
    (social_id.nil? and service_id.nil?) or (social_id.empty? and service_id.empty?)
  end
end
