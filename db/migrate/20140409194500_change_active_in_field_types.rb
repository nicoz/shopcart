class ChangeActiveInFieldTypes < ActiveRecord::Migration
  def change
    change_column :field_types, :active, :boolean, default: true
  end
end
