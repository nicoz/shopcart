class CreateItemInstanceValues < ActiveRecord::Migration
  def change
    create_table :item_instance_values do |t|
      t.integer :item_instance_id
      t.integer :item_field_id
      t.text :value

      t.timestamps
    end
    
    add_index :item_instance_values, [:id, :item_instance_id, :item_field_id],  name: 'value_index'
  end
end
