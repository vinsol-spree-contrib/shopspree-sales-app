# This migration comes from spree_wishlist (originally 20140403013413)
class RemoveWishedProductsForDeletedVariants < ActiveRecord::Migration
  def up
    Spree::WishedProduct.includes(:variant).find_each do |wished_product|
      wished_product.destroy unless wished_product.variant
    end
  end

  def down
  end
end
