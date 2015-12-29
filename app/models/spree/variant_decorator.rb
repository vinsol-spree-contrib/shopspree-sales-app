Spree::Variant.class_eval do

  def options_hash
    self.option_values.inject({}) do |option_values_acc, option_value|
      option_values_acc[option_value.option_type.presentation] = option_value.presentation
      option_values_acc
    end
  end

end
