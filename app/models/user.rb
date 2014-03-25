# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  
  has_secure_password
  
  mount_uploader :avatar, AvatarUploader
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }
  validate :password_sintax
  
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
