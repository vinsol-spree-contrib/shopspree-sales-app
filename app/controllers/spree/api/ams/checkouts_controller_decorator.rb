Spree::Api::Ams::CheckoutsController.class_eval do

  # See Issue: https://github.com/vinsol/spree-next/issues/3

  before_action -> { old_load_order(true) }

  alias_method :old_load_order, :load_order

  def load_order(arg)
  end

  private

  def raise_insufficient_quantity
    @order.errors[:base] = "Insufficient stock for some line item."
    respond_with(@order, status: 422)
  end

end
