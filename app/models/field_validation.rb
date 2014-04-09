# == Schema Information
#
# Table name: field_validations
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  parameters    :text
#  field_type_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class FieldValidation < ActiveRecord::Base
end
