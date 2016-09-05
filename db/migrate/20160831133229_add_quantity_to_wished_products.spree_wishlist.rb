# This migration comes from spree_wishlist (originally 20150805204533)
class AddQuantityToWishedProducts < ActiveRecord::Migration
  def change
    add_column :spree_wished_products, :quantity, :integer, null: false, default: 1
  end
end
