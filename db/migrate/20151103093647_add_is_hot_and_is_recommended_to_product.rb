class AddIsHotAndIsRecommendedToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :is_hot, :boolean, default: false
    add_column :spree_products, :is_recommended, :boolean, default: false
  end
end
