class RemoveTypesFromSpreeBanners < ActiveRecord::Migration
  def change
    remove_column :spree_banners, :type
  end

  def down
    add_column :spree_banners, :type, :string
  end
end
