Spree::Api::Ams::LineItemsController.class_eval do
  def destroy
    @line_item = find_line_item
    variant = Spree::Variant.unscoped.find(@line_item.variant_id)
    @order.contents.remove(variant, @line_item.quantity)
    # NOT WORKING. Empty response being rendered
    render json: { success: true }, status: 204
  end
end
