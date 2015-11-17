class Spree::BannerType < ActiveRecord::Base
  validates :name, :presentation, presence: true
  validates :name, :presentation, uniqueness: true, allow_blank: true

  has_many :banners, foreign_key: :type_id, dependent: :restrict_with_error
end
