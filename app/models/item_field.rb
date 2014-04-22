# == Schema Information
#
# Table name: item_fields
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  label           :string(255)
#  searchable      :boolean          default(FALSE)
#  active          :boolean          default(TRUE)
#  field_type_id   :integer
#  created_at      :datetime
#  updated_at      :datetime
#  item_version_id :integer
#  act_as          :string(255)      default("value")
#  weight          :integer          default(0)
#

class ItemField < ActiveRecord::Base
  belongs_to :item_version
  belongs_to :field_type
  
  validates :name,          presence: true
  validates :name,          uniqueness: {scope: :item_version_id}
  validates :label,         presence: true
  validates :field_type_id, presence: true
  validates :act_as,        inclusion: {in: %w(principal secondary small_description long_description price unit amount category subcategory tax), allow_nil: true}
  validates :act_as,        uniqueness: {scope: :item_version_id, allow_nil: true}
  validates :weight,        uniqueness: {scope: :item_version_id, allow_nil: true}
  
  before_validation(on: [:create, :update]) do
    #The select in the view passes an empty String instead of nil which is
    #allowed in the validation.
    if !self.act_as.nil? and self.act_as.empty?
      self.act_as = nil
    end
  end


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
  
  def self.next_weight(id)
    value = ItemField.where(item_version_id: id).order('weight').last.try(:weight)
    return value.nil? ? 10 : value + 10
  end
end
