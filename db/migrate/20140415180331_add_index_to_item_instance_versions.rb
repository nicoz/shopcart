class AddIndexToItemInstanceVersions < ActiveRecord::Migration
  def change
    add_index :item_instance_versions, [:item_instance_id, :id]
  end
end
