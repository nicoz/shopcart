class RemoveAcviteFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :acvite
  end
end
