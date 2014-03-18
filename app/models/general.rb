class General < ActiveRecord::Base
  #attr_accessor :name, :title, :slogan, :logo, :icon
   
  mount_uploader :logo, ImageUploader
  mount_uploader :icon, ImageUploader
  
  validates :name, presence: true
  validates :title, presence: true
  validates :slogan, presence: true
end
