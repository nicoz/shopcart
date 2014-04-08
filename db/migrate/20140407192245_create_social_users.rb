class CreateSocialUsers < ActiveRecord::Migration
  def change
    create_table :social_users do |t|
      t.integer :user_id
      t.integer :service_id
      t.string :name
      t.string :email
      t.string :social_id
      t.string :social_name
      t.string :social_token

      t.timestamps
    end
  end
end
