module Spree
  class HomeDecorator
    include ActiveModel::Serialization

    def hot_products
      Spree::Product.hot.random.includes(:product_properties, :variants_including_master, master: :images).limit(5)
    end

    def recommended_products
      Spree::Product.recommended.random.includes(:product_properties, :variants_including_master, master: :images).limit(5)
    end
  end
end
