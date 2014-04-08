# == Schema Information
#
# Table name: social_users
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  service_id   :integer
#  name         :string(255)
#  email        :string(255)
#  social_id    :string(255)
#  social_name  :string(255)
#  social_token :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class SocialUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :service
end
