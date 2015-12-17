# This migration comes from spree_reviews (originally 20120712182627)
class AddLocaleToFeedbackReviews < ActiveRecord::Migration
  def self.up
    add_column :spree_feedback_reviews, :locale, :string, default: 'en'
  end

  def self.down
    remove_column :spree_feedback_reviews, :locale
  end
end
