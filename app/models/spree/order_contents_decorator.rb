Spree::OrderContents.class_eval do
  alias_method :existing_remove, :remove

  def remove(variant, quantity = 1, options = {})
    result = existing_remove(variant, quantity, options)
    if order.line_items.present?
      result
    else
      order.destroy!
    end
  end
end
