class CreateFieldPosibilities < ActiveRecord::Migration
  def change
    create_table :field_posibilities do |t|
      t.string :text
      t.integer :field_type_id

      t.timestamps
    end
  end
end
