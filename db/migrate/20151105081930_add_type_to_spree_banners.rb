class AddTypeToSpreeBanners < ActiveRecord::Migration
  def change
    add_column :spree_banners, :type, :string
  end
end
