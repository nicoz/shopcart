class CreateOrdenCompras < ActiveRecord::Migration
  def change
    create_table :orden_compras do |t|
      t.float :total
      t.boolean :estado

      t.timestamps
    end
  end
end
