# == Schema Information
#
# Table name: services
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  active       :boolean          default(TRUE)
#  service_type :string(255)
#

class Service < ActiveRecord::Base
  has_many  :serviceInformation

  validates :name,    presence: true #, format: { with: /\A[a-zA-Z0-9.-]+\z/ }

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
