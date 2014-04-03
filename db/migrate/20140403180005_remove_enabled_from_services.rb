class RemoveEnabledFromServices < ActiveRecord::Migration
  def change
    remove_column  :services, :enabled
  end
end
