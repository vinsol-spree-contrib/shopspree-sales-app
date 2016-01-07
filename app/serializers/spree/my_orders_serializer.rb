module Spree
  class MyOrdersSerializer < ActiveModel::Serializer

    attributes :count, :current_page, :pages, :orders

    def count
      object.count
    end

    def current_page
      options[:current_page] || 1
    end

    def pages
      object.num_pages
    end

    def orders
      object.collect { |order| Spree::OrderSerializer.new(order) }
    end
  end
end
