# == Schema Information
#
# Table name: field_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  active     :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#  field_type :string(255)
#

class FieldType < ActiveRecord::Base
  has_many :item_fields
  
  validates :name,    presence: true
  validates :field_type, inclusion: { in: %w(value image file list) }
  
  def destroy
    self.active = false
    self.save
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
