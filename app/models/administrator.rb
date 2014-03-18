#this class assist in creating the first user that will be used in the system
#it purpouse is to help separate the concepts of a normal user creation 
# that includes adding Roles to it, and other particular data, such as its name, etc.
class Administrator
  include ActiveModel::Model
  include ActiveModel::Serialization
  include ActiveModel::AttributeMethods
  
  attribute_method_affix  prefix: 'reset_', suffix: '_to_default!'
  attribute_method_suffix '_contrived?'
  attribute_method_prefix 'clear_'
  #define_attribute_methods :name, :password, :confirmation
  
  attr_accessor :attributes, :email, :password, :confirmation
  
  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true, length: { minimum: 8 }
  validate :password_sintax
  validates :confirmation, presence: true
  validate :fields_match
  
  include ActiveModel::Serialization
 
 
  def initialize(attributes={})
    self.attributes = attributes
    self.email = self.attributes[:email] if self.attributes[:email]
    self.password = self.attributes[:password] if self.attributes[:password]
    self.confirmation = self.attributes[:confirmation] if self.attributes[:confirmation]
  end

  def fields_match
    if password != confirmation
      errors.add(:confirmation, "and Password must match")
    end
  end
  
  def password_sintax
    unless self.password.nil? or self.password.empty?
      splitted = self.password.split(//)
      has_at_least_one_upcase = false
      has_at_least_one_downcase = false
      has_at_least_one_number = false
      letters = ("a".."z").to_a + ("A".."Z").to_a
      numbers = ("0".."9").to_a
      splitted.each do |element|
        
        has_at_least_one_upcase = (element.upcase == element and letters.include?(element)) unless has_at_least_one_upcase
        has_at_least_one_downcase = (element.downcase == element and letters.include?(element)) unless has_at_least_one_downcase
        has_at_least_one_number = numbers.include?(element) unless has_at_least_one_number
      end
      
      errors.add(:password, "must have at least one upcase letter") unless has_at_least_one_upcase
      errors.add(:password, "must have at least one downcase letter") unless has_at_least_one_downcase
      errors.add(:password, "must have at least one number") unless has_at_least_one_number
    end
  end

end
