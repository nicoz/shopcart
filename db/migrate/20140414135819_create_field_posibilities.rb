class CreateFieldPosibilities < ActiveRecord::Migration
  def change
    create_table :field_posibilities do |t|
      t.integer :field_type_id
      t.string :text
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
