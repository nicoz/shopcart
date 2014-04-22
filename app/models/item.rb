# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  active     :boolean          default(TRUE)
#  image      :string(255)
#

class Item < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  
  has_many :item_versions
  
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
  
  def lines(params)
    if !params[:state].nil? and !params[:state].empty?
      lines = ItemVersion.where(item_id: self.id).where(state: params[:state]).order(['state desc', 'created_at'])
    else
      @lines = ItemVersion.where(item_id: self.id).order(['state desc', 'created_at'])
    end
  end
  
  def current_version
    ItemVersion.where(item_id: self.id).where(state: 'close').order('created_at').last
  end
  
  def self.active_items
    items = Item.joins(:item_versions).group('items.id').where(active: true).where('item_versions.state = ?', 'close' )
  end
  
  def self.by_name(name)
    Item.where("LOWER(name) = ?", name.downcase).where(active: true).first
  end
end
