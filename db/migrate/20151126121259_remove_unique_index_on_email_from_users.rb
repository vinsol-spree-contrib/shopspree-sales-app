class RemoveUniqueIndexOnEmailFromUsers < ActiveRecord::Migration
  def change
    remove_index :spree_users, name: :email_idx_unique
    add_index :spree_users, :email
  end
end
