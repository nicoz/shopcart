class Drop < ActiveRecord::Migration
  def change
    drop_table 'application_configurations'
  end
end
