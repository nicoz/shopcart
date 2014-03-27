# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  enabled    :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Service < ActiveRecord::Base
  has_many  :serviceInformation

  validates :name,    presence: true, format: { with: /\A[a-zA-Z0-9.-]+\z/ }
  validates :enabled, presence: true
end
