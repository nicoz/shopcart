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

class FieldMap < ActiveRecord::Base

  belongs_to :field_type
  
  validates :key, presence: true, uniqueness: {scope: :field_type_id}
  validates :value, presence: true

  def destroy
    if self.active
      self.active = false
      self.save
    else
      nil
    end
  end
  
  def activate
    if !self.active
      self.active = true
      self.save
    else
      nil
    end
  end
end
