class AddTypeIdToBanners < ActiveRecord::Migration
  def change
    add_column :spree_banners, :type_id, :integer
    add_index :spree_banners, :type_id
  end
end
