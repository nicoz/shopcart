# == Schema Information
#
# Table name: item_versions
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  state      :string(255)      default("open")
#  created_at :datetime
#  updated_at :datetime
#

class ItemVersion < ActiveRecord::Base
  belongs_to :item
  has_many :item_fields
  has_many :item_instances
  
  validates :state, inclusion: {in: %w(open close cancel)}
  
  def close
    if self.state == 'open'
      self.state = 'close'
      if self.save
        return self
      else
        return nil
      end
    else
      return nil
    end
  end
  
  def destroy
    if self.state == 'open'
      self.state = 'cancel'
      if self.save
        return self
      else
        return nil
      end
    else
      return nil
    end
  end
  
  def lines(params)
    if !params[:name].nil? and !params[:name].empty?
      @lines = ItemField.where(item_version_id: self.id).where(active: params[:inactive] != 'on').where(state: params[:name]).order('weight')
    else
      @lines = ItemField.where(active: params[:inactive] != 'on').where(item_version_id: self.id).order('weight')
    end
  end
  
  def searchable_fields
    ItemField.where(item_version_id: self.id).where(active: true).where(searchable: true).order('weight')
  end
end
