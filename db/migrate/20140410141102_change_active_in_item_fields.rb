class ChangeActiveInItemFields < ActiveRecord::Migration
  def change
    change_column :item_fields, :active, :boolean, default: true
  end
end
