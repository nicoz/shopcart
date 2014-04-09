class CreateItemInstances < ActiveRecord::Migration
  def change
    create_table :item_instances do |t|
      t.integer :item_id
      t.boolean :active

      t.timestamps
    end
  end
end
