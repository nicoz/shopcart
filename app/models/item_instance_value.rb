# == Schema Information
#
# Table name: item_instance_values
#
#  id               :integer          not null, primary key
#  item_instance_id :integer
#  item_field_id    :integer
#  value            :text
#  created_at       :datetime
#  updated_at       :datetime
#

class ItemInstanceValue < ActiveRecord::Base
end
