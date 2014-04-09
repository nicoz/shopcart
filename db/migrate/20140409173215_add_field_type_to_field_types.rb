class AddFieldTypeToFieldTypes < ActiveRecord::Migration
  def change
    add_column :field_types, :field_type, :string
  end
end
