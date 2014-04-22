class AddImageToItemInstanceVersionValues < ActiveRecord::Migration
  def change
    add_column :item_instance_version_values, :image, :string
  end
end
