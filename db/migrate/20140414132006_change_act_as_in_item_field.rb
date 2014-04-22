class ChangeActAsInItemField < ActiveRecord::Migration
  def change
    change_column :item_fields, :act_as, :string
  end
end
