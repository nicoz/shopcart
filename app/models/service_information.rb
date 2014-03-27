# == Schema Information
#
# Table name: service_informations
#
#  id         :integer          not null, primary key
#  service_id :integer
#  key        :string(255)
#  value      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ServiceInformation < ActiveRecord::Base
  belongs_to :service,    dependent: :destroy

  validates  :service_id, presence: true
  validates  :key,        presence: true
  validates  :value,      presence: true
end
