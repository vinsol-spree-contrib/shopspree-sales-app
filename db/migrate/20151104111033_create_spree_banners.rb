class CreateSpreeBanners < ActiveRecord::Migration
  def change
    create_table :spree_banners do |t|
      t.string :target_url

      t.timestamps null: false
    end
  end
end
