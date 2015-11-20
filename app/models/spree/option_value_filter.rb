module Spree
  class OptionValueFilter < Spree::Filter

    def values
      product_list.option_values.pluck(:presentation)
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