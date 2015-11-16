class RemoveIsHotAndIsRecommendedFromProducts < ActiveRecord::Migration
  def change
    remove_column :spree_products, :is_hot
    remove_column :spree_products, :is_recommended
  end
end
