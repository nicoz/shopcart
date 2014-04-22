class ChangeColumnActiveInItemInstances < ActiveRecord::Migration
  def change
    change_column :item_instances, :active, :boolean, default: true
  end
end
