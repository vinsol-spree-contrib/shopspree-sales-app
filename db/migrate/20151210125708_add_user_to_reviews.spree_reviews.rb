# This migration comes from spree_reviews (originally 20110606150524)
class AddUserToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :user_id, :integer, null: true
  end

  def self.down
    remove_column :reviews, :user_id
  end
end
