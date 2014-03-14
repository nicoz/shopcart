#this class assist in creating the first user that will be used in the system
#it purpouse is to help separate the concepts of a normal user creation 
# that includes adding Roles to it, and other particular data, such as its name, etc.
class Administrator
  include ActiveModel::Model
  include ActiveModel::AttributeMethods
  
  attribute_method_affix  prefix: 'reset_', suffix: '_to_default!'
  attribute_method_suffix '_contrived?'
  attribute_method_prefix 'clear_'
  define_attribute_methods :name, :password, :confirmation
  
  attr_accessor :email, :password, :confirmation
  
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 8 }
  validate :password_sintax
  validates :confirmation, presence: true
  validate :fields_match
  
  def fields_match
    if password != confirmation
      errors.add(:confirmation, "and Password must match")
    end
  end
  
  def password_sintax
    splitted = password.split(//)
    has_at_least_one_upcase = false
    has_at_least_one_downcase = false
    has_at_least_one_number = false
    
    splitted.each do |element|
      has_at_least_one_upcase = (element.upcase == element and !element.is_a?(Integer)) unless has_at_least_one_upcase
      has_at_least_one_downcase = (element.downcase == element and !element.is_a?(Integer)) unless has_at_least_one_downcase
      has_at_least_one_number = ("0".."9").to_a.include?(element) unless has_at_least_one_number
    end
    
    errors.add(:password, "must have at least one upcase letter") unless has_at_least_one_upcase
    errors.add(:password, "must have at least one downcase letter") unless has_at_least_one_downcase
    errors.add(:password, "must have at least one number") unless has_at_least_one_number
  end
  
  def attributes
    {email: @email, password: @password, confirmation: @confirmation}
  end

  private
    #Definition of attributes methods from ActiveRecord
    def attribute_contrived?(attr)
      true
    end

    def clear_attribute(attr)
      send("#{attr}=", nil)
    end

    def reset_attribute_to_default!(attr)
      send("#{attr}=", 'Default Name')
    end
end
