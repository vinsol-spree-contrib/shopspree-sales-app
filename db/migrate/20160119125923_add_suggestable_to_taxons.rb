class AddSuggestableToTaxons < ActiveRecord::Migration
  def change
    add_column :spree_taxons, :suggestable, :boolean, default: false
  end
end
