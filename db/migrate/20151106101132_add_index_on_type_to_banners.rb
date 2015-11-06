class AddIndexOnTypeToBanners < ActiveRecord::Migration
  def change
    add_index :spree_banners, :type
  end
end
