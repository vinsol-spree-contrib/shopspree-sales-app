class CreateSpreeDevices < ActiveRecord::Migration
  def change
    create_table :spree_devices do |t|
      t.string :device_token
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
