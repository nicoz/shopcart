# == Schema Information
#
# Table name: field_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  active     :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#  field_type :string(255)
#

class FieldType < ActiveRecord::Base
  has_many :item_fields
  has_many :field_posibilities
  has_many :field_maps
  
  validates :name,    presence: true
  validates :field_type, inclusion: { in: %w(value boolean memo image file list map) }
  
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
  
  def lines(params)
    if self.field_type == 'list'
      if !params[:text].nil? and !params[:text].empty?
        @lines = FieldPosibility.where(field_type_id: self.id).where(active: params[:inactive] != 'on').where("LOWER(text) like ?", "%#{params[:text].downcase}%")
      else
        @lines = FieldPosibility.where(field_type_id: self.id).where(active: params[:inactive] != 'on')
      end
    else 
      if self.field_type == 'map'
        if !params[:key].nil? and !params[:key].empty?
          @lines =  FieldMap.where(field_type_id: self.id).where(active: params[:inactive] != 'on').where("LOWER(key) like ?", "%#{params[:key].downcase}%")
        else
          @lines = FieldMap.where(field_type_id: self.id).where(active: params[:inactive] != 'on')
        end
      end
    end
  end
end
