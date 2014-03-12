class Administrator
  include ActiveModel::Model
  attr_accessor :email, :password, :confirmation
  
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 8 }
  validate :correct_password_sintax
  validates :confirmation, presence: true
  validate :passwords_must_match
  
  def passwords_must_match
    if password != confirmation
      errors.add(:confirmation, "and Password must match")
    end
  end
  
  def correct_password_sintax
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
  
end
