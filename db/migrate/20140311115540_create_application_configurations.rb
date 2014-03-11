class CreateApplicationConfigurations < ActiveRecord::Migration
  def change
    create_table :application_configurations do |t|
      t.string :name
      t.string :title
      t.string :slogan
      t.string :logo
      t.string :icon

      t.timestamps
    end
  end
end
