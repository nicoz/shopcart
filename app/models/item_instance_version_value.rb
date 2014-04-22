# == Schema Information
#
# Table name: item_instance_version_values
#
#  id                       :integer          not null, primary key
#  value                    :text
#  item_field_id            :integer
#  item_instance_version_id :integer
#  created_at               :datetime
#  updated_at               :datetime
#  image                    :string(255)
#

class ItemInstanceVersionValue < ActiveRecord::Base
  belongs_to :item_field
  belongs_to :item_instance_version
  
  mount_uploader :image, ImageUploader
  
  def self.orderer_values(options = {})
    ItemInstanceVersionValues.joins(:item_fields).where(item_instance_version_id: options[:item_instance_version_id]).order('weight')
  end
end
