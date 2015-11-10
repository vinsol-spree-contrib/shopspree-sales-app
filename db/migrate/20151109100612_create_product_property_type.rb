class CreateProductPropertyType < ActiveRecord::Migration
  def change
    create_table :spree_product_property_types do |t|
      t.string :name

      t.timestamps null: false
    end
    add_index :spree_product_property_types, :name, unique: true
  end
end
