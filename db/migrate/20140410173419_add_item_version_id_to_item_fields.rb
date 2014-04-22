class AddItemVersionIdToItemFields < ActiveRecord::Migration
  def change
    add_column :item_fields, :item_version_id, :integer
    
    remove_column :item_fields, :item_id
  end
end
