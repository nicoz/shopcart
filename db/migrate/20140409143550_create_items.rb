class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.boolean :acvite, default: :true

      t.timestamps
      
    end
    
    add_index :items, :name
  end
end
