module Spree
  Review.class_eval do

  validators.each do |a|
    a.attributes.reject! {|field| field.to_s =~ /name|review/ } if a.kind == :presence
  end

  validates :name, :review, presence: true, if: :name_or_review_present?

  default_scope { order(created_at: :desc) }

  scope :ratings_with_reviews, -> { where.not(name: '') }
  scope :approved, -> { where(approved: true) }

  private
    def name_or_review_present?
      name.present? || review.present?
    end

  end
end