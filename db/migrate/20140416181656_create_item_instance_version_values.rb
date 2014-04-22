class CreateItemInstanceVersionValues < ActiveRecord::Migration
  def change
    create_table :item_instance_version_values do |t|
      t.text :value
      t.integer :item_field_id
      t.integer :item_instance_version_id

      t.timestamps
    end
  end
end
