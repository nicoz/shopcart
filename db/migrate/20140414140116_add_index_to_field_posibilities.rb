class AddIndexToFieldPosibilities < ActiveRecord::Migration
  def change
    add_index :field_posibilities, [:field_type_id, :text]
  end
end
