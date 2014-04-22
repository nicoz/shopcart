class CreateItemVersions < ActiveRecord::Migration
  def change
    create_table :item_versions do |t|
      t.integer :item_id
      t.string :state, default: 'open'

      t.timestamps
    end
    
    add_index :item_versions, [:item_id, :state]
  end
end
