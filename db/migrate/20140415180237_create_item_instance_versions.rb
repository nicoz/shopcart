class CreateItemInstanceVersions < ActiveRecord::Migration
  def change
    create_table :item_instance_versions do |t|
      t.integer :item_instance_id

      t.timestamps
    end
  end
end
