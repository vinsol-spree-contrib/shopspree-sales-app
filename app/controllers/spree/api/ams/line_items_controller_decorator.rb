Spree::Api::Ams::LineItemsController.class_eval do
  include RespondWithResourceErrors

  # order.contents.add raises an exception instead of validation errors
  rescue_from ActiveRecord::RecordInvalid do |exception|
    self.render_order_with_errors(exception.message.sub("Validation failed: ", ""))
  end

  before_action -> { order.restart_checkout_flow }


  def create
    variant = Spree::Variant.find(params[:line_item][:variant_id])
    @line_item = order.contents.add(
            variant,
            params[:line_item][:quantity] || 1,
            line_item_params[:options] || {}
    )

    if @line_item.errors.empty?
      respond_with(@line_item.order, status: 201, default_template: :show)
    else
      render_order_with_errors
    end
  end

  def update
    @line_item = find_line_item
    if @order.contents.update_cart(line_items_attributes)
      @line_item.reload
      respond_with(@line_item.order, default_template: :show)
    else
      render_order_with_errors
    end
  end

  def destroy
    @line_item = find_line_item
    variant = Spree::Variant.unscoped.find(@line_item.variant_id)
    @order.contents.remove(variant, @line_item.quantity)
    if @order.destroyed?
      render json: nil, status: 204
    else
      respond_with(@order)
    end
  end


  # Order automatically gets the error for nested line items
  def render_order_with_errors(*error_messages)
    @order.errors[:base].push(*error_messages) unless error_messages.empty?
    invalid_resource!(@order)
  end

end
