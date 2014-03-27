class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.boolean :enabled

      t.timestamps
    end
  end
end
