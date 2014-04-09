class CreateFieldValidations < ActiveRecord::Migration
  def change
    create_table :field_validations do |t|
      t.string :name
      t.text :parameters
      t.integer :field_type_id

      t.timestamps
    end
  end
end
