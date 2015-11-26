class RemoveTypesFromSpreeBanners < ActiveRecord::Migration
  def change
    remove_column :spree_banners, :type_id
  end

  def down
    add_column :spree_banners, :type_id, :string
  end
end
