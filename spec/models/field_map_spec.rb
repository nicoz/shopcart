# == Schema Information
#
# Table name: field_maps
#
#  id            :integer          not null, primary key
#  field_type_id :integer
#  key           :string(255)
#  value         :string(255)
#  active        :boolean          default(TRUE)
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe FieldMap do
  pending "add some examples to (or delete) #{__FILE__}"
end
