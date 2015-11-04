class AddAttachmentImageToSpreeBanners < ActiveRecord::Migration
  def self.up
    change_table :spree_banners do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :spree_banners, :image
  end
end
