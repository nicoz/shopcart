class RemoveColumnItemIdInItemInstance < ActiveRecord::Migration
  def change
    remove_column :item_instances, :item_id
    add_column :item_instances, :item_version_id, :integer
  end
end
