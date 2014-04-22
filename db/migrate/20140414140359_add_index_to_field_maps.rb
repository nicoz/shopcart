class AddIndexToFieldMaps < ActiveRecord::Migration
  def change
    add_index :field_maps, [:field_type_id, :key]
  end
end
