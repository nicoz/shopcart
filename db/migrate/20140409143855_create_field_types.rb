class CreateFieldTypes < ActiveRecord::Migration
  def change
    create_table :field_types do |t|
      t.string :name
      t.boolean :active, default: :true

      t.timestamps
    end
    
    add_index :field_types, :name
  end
end
