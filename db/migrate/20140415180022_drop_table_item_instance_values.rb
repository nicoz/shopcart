class DropTableItemInstanceValues < ActiveRecord::Migration
  def change
    drop_table :item_instance_values
  end
end
