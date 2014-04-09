class CreateItemFields < ActiveRecord::Migration
  def change
    create_table :item_fields do |t|
      t.string :name
      t.string :label
      t.boolean :searchable, default: :false
      t.boolean :active, default: :true
      t.integer :item_id
      t.integer :field_type_id

      t.timestamps
    end
    
    add_index :item_fields, [:item_id, :id]
  end
end
