class CreateServiceInformations < ActiveRecord::Migration
  def change
    create_table :service_informations do |t|
      t.integer :service_id
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
