class CreateItemFieldPosibilities < ActiveRecord::Migration
  def change
    create_table :item_field_posibilities do |t|
      t.integer :item_field_id
      t.string :text

      t.timestamps
    end
  end
end
