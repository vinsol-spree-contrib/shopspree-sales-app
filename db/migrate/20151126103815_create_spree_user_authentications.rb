class CreateSpreeUserAuthentications < ActiveRecord::Migration
  def change
    create_table :spree_user_authentications do |t|
      t.string :uid
      t.string :provider
      t.integer :user_id
      t.string :profile_pic_url
    end

    add_index :spree_user_authentications, [:provider, :user_id]
  end
end
