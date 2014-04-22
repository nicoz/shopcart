class AddActAsAndWeightToItemFields < ActiveRecord::Migration
  def change
    add_column :item_fields, :act_as, :string, default: 'value'
    add_column :item_fields, :weight, :integer, default: 0
  end
  
end
