class CreateSpreeSalesAppConfigurations < ActiveRecord::Migration
  def change
    create_table :spree_sales_app_configurations do |t|
      t.string :states_checksum
      t.string :home_checksum
      t.string :taxonomies_checksum

      t.timestamps null: false
    end
  end
end
