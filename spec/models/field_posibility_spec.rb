# == Schema Information
#
# Table name: field_posibilities
#
#  id            :integer          not null, primary key
#  field_type_id :integer
#  text          :string(255)
#  active        :boolean          default(TRUE)
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe FieldPosibility do
  pending "add some examples to (or delete) #{__FILE__}"
end
