class AddApiRequiredFieldsToUsers < ActiveRecord::Migration
  def change
    change_table :spree_users do |t|
      t.string :profile_pic_url
      t.string :uid
      t.string :login_type
      t.string :full_name
    end
  end
end
