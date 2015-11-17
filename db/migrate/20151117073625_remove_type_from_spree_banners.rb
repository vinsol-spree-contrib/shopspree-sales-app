class RemoveTypeFromSpreeBanners < ActiveRecord::Migration
  def up
    remove_index :spree_banners, :type
    remove_column :spree_banners, :type
  end

  def down
    add_column :spree_banners, :type, :string
    add_index :spree_banners, :type
  end
end
