class AddEnabledForFiltersToProperties < ActiveRecord::Migration
  def change
    add_column :spree_properties, :enabled_for_filters, :boolean, default: false
    add_index :spree_properties, :enabled_for_filters
  end
end
