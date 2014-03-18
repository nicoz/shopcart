# == Schema Information
#
# Table name: static_pages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

class StaticPage < ActiveRecord::Base
end
