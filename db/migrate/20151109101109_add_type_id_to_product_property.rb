class AddTypeIdToProductProperty < ActiveRecord::Migration
  def change
    add_column :spree_product_properties, :type_id, :integer
    add_index :spree_product_properties, :type_id
  end
end
