module Spree
  class OptionValueFilter < Spree::Filter

    def values
      option_values.pluck(:presentation)
    end

    def option_values
      Spree::OptionValue.joins(variants: :product).merge(product_scope).includes(:option_type).uniq
    end

    def search_key
      if type.eql?('Single')
        :variants_option_values_presentation_cont
      elsif type.eql?('Multiple')
        :variants_option_values_presentation_in
      end
    end

  end
end