class AddActiveToServiceInformations < ActiveRecord::Migration
  def change
    add_column :service_informations, :active, :boolean, default: true
  end
end
