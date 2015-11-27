class AddPhoneToSpreeUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :phone, :string
  end
end
