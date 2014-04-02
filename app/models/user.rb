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
  before_save { self.email = self.email.downcase }
  before_create :create_remember_token 
  
  attr_accessor :updating_password, :updating_data, :reseting_password, :old_password
  
  has_secure_password
  
  mount_uploader :avatar, AvatarUploader
  
  validates :name, presence: true, length: { maximum: 50 }, if: :should_validate_data?
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }, if: :should_validate_data?
  validates :password, length: { minimum: 8 }, if: :should_validate_password?
  validate :password_sintax, if: :should_validate_password?
  validate :old_password_matches, if: :should_validate_old_password?
  
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
  
  def old_password_matches
    return if password_digest_was.nil? || !password_digest_changed?
    unless BCrypt::Password.new(password_digest_was) == old_password
      errors.add(:old_password, "Must match the current password")
    end
  end
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def is_admin?
    self.admin
  end
  
  def destroy
    self.active = false
    self.save
  end
  
  def activate
    if !self.active
      self.active = true
      self.save
    else
      nil
    end
  end
  
  private
    def should_validate_password?
      updating_password ||  reseting_password || new_record?
    end
    
    def should_validate_old_password?
      updating_password
    end

    def should_validate_data?
      updating_data || new_record?
    end
    
    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end
