# == Schema Information
#
# Table name: item_fields
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  label         :string(255)
#  searchable    :boolean          default(FALSE)
#  active        :boolean          default(TRUE)
#  item_id       :integer
#  field_type_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class ItemField < ActiveRecord::Base
  belongs_to :item
  
end
