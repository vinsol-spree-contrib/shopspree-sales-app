module Spree
  Review.class_eval do

  validators.each do |a|
    a.attributes.reject! {|field| field.to_s =~ /name|review/ } if a.kind == :presence
  end

  validates :name, :review, presence: true, if: :name_or_review_present?

  scope :reviewed_ratings, -> { where.not(name: '') }
  scope :approved, -> { where(approved: true) }
  scope :most_recent, ->(count) { order(created_at: :desc).limit(count) }

  private
    def name_or_review_present?
      name.present? || review.present?
    end

  end
end