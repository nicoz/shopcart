class AddIndexWeightToItemFields < ActiveRecord::Migration
  def change
    add_index :item_fields, :weight
  end
end
