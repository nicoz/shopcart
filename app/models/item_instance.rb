# == Schema Information
#
# Table name: item_instances
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  active     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class ItemInstance < ActiveRecord::Base
end
