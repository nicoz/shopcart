class CreateGenerals < ActiveRecord::Migration
  def change
    create_table :generals do |t|
      t.string :name
      t.string :title
      t.string :slogan
      t.string :icon
      t.string :logo

      t.timestamps
    end
  end
end
