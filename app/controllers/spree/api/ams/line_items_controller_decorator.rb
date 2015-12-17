Spree::Api::Ams::LineItemsController.class_eval do
  def destroy
    @line_item = find_line_item
    variant = Spree::Variant.unscoped.find(@line_item.variant_id)
    @order.contents.remove(variant, @line_item.quantity)
    # Status code changed to 200 OK,
    # status code of 204 implies no content.
    render json: { success: true }, status: 200
  end
end
