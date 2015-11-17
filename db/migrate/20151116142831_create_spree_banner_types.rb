class CreateSpreeBannerTypes < ActiveRecord::Migration
  def change
    create_table :spree_banner_types do |t|
      t.string :name
      t.string :presentation

      t.timestamps null: false
    end
  end
end
