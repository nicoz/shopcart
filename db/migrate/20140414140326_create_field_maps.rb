class CreateFieldMaps < ActiveRecord::Migration
  def change
    create_table :field_maps do |t|
      t.integer :field_type_id
      t.string :key
      t.string :value
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
