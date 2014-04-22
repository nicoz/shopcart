# == Schema Information
#
# Table name: item_instances
#
#  id              :integer          not null, primary key
#  active          :boolean
#  created_at      :datetime
#  updated_at      :datetime
#  item_version_id :integer
#

class ItemInstance < ActiveRecord::Base
  belongs_to :item_version
  has_many :item_instance_versions
  
  
  def new_version(options = {})
    item_instance_version = ItemInstanceVersion.new(item_instance_id: self.id)
    self.item_version.item_fields.each do |field|
      instance_value = ItemInstanceVersionValue.new(item_field_id: field.id)
        item_instance_version.item_instance_version_values << instance_value
    end

    item_instance_version
  end
  
  def clone_version(current_version)
    new_version = ItemInstanceVersion.new(item_instance_id: current_version.item_instance.id)
    current_version.item_instance_version_values.each do |value|
      new_value = ItemInstanceVersionValue.new(value: value.value, image: value.image, item_field_id: value.item_field_id)
      new_version.item_instance_version_values << new_value
    end
    
    new_version
  end
  
  def current_version
    self.item_instance_versions.order('created_at desc').first
  end
  
  def destroy
    self.active = false
    self.save
  end
  
  def active?
    self.active
  end
  
  def activate
    if !self.active?
      self.active = true
      self.save
    else
      nil
    end
  end
end
