class AddApiRequiredFieldsToUsers < ActiveRecord::Migration
  def change
    change_table :spree_users do |t|
      t.string :full_name
    end
  end
end
