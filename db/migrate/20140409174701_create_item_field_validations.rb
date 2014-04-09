class CreateItemFieldValidations < ActiveRecord::Migration
  def change
    create_table :item_field_validations do |t|
      t.integer :item_field_id
      t.integer :field_validation_id

      t.timestamps
    end
  end
end
