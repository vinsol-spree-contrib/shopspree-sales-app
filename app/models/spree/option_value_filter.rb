module Spree
  class OptionValueFilter < Spree::Filter

    def values
      product_list.option_values.pluck(:presentation)
    end

  end
end