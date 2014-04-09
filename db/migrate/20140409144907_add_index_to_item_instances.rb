class AddIndexToItemInstances < ActiveRecord::Migration
  def change
    change_column :item_instances, :active, :boolean, defautl: :true
    
    add_index :item_instances, :item_id
  end
end
