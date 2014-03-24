# == Schema Information
#
# Table name: generals
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  title      :string(255)
#  slogan     :string(255)
#  icon       :string(255)
#  logo       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class General < ActiveRecord::Base
  #attr_accessor :name, :title, :slogan, :logo, :icon
   
  mount_uploader :logo, ImageUploader
  mount_uploader :icon, ImageUploader
  
  validates :name, presence: true
  validates :title, presence: true
  validates :slogan, presence: true
end
