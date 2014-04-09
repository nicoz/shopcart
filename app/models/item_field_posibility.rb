# == Schema Information
#
# Table name: item_field_posibilities
#
#  id            :integer          not null, primary key
#  item_field_id :integer
#  text          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class ItemFieldPosibility < ActiveRecord::Base
end
