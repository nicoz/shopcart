# == Schema Information
#
# Table name: item_field_validations
#
#  id                  :integer          not null, primary key
#  item_field_id       :integer
#  field_validation_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class ItemFieldValidation < ActiveRecord::Base
end
