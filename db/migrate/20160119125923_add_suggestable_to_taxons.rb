class AddSuggestableToTaxons < ActiveRecord::Migration
  def change
    add_column :spree_taxons, :suggestable, :boolean, default: false
    add_index  :spree_taxons, :suggestable
  end
end
