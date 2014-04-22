# == Schema Information
#
# Table name: service_informations
#
#  id         :integer          not null, primary key
#  service_id :integer
#  key        :string(255)
#  value      :text(255)
#  created_at :datetime
#  updated_at :datetime
#  active     :boolean          default(TRUE)
#

class ServiceInformation < ActiveRecord::Base
  belongs_to :service,    dependent: :destroy

  validates  :service_id, presence: true
  validates  :key,        presence: true, uniqueness: 
    { scope: :service, message: 'Ya existe la clave para este servicio' }
  validates  :value,      presence: true
  
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
