class CreateFilters < ActiveRecord::Migration
  def change
    create_table :spree_filters do |t|
      t.string :name
      t.string :display_name
      t.string :type
      t.boolean :enabled, default: false
      t.timestamps
    end
    add_index :spree_filters, [:type, :name]
  end
end
