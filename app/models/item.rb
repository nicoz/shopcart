# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  active     :boolean          default(TRUE)
#

class Item < ActiveRecord::Base
  has_many :item_fields
  
  validates :name,    presence: true

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
