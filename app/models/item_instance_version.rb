# == Schema Information
#
# Table name: item_instance_versions
#
#  id               :integer          not null, primary key
#  item_instance_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class ItemInstanceVersion < ActiveRecord::Base
  has_many :item_instance_version_values
  belongs_to :item_instance
  accepts_nested_attributes_for :item_instance_version_values
  
  def orderer_values
    self.item_instance_version_values.sort {|a,b| a.item_field.weight <=> b.item_field.weight}
  end
  
  def value(options = {})
    final = nil
    unless options[:act_as].nil?
      Rails.logger.info 'VIA ACT_AS'
      return self.item_instance_version_values.joins(:item_field)
        .where('item_fields.act_as=?', options[:act_as]).first
    end
    unless options[:name].nil?
      Rails.logger.info 'VIA NAME'
      return self.item_instance_version_values.joins(:item_field)
        .where('lower(item_fields.name)=?', options[:name].downcase).first
    end
    
    final
  end
  
end
