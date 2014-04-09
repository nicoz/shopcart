class ChangeColumnsTypesInServiceInformations < ActiveRecord::Migration
  def change
    change_column :service_informations, :value, :text
  end
end
