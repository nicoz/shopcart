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

class FieldPosibility < ActiveRecord::Base

  belongs_to :field_type
  
  validates :text, presence: true, uniqueness: {scope: :field_type_id}
  
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
