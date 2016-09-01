module Spree
  module Api
    module Ams
      class WishedProductsController < Spree::StoreController

        before_action :load_wished_product, only: [:update, :destroy]
        before_action :load_default_wishlist, only: :create

        def create
          authorize! :create, WishedProduct
          @wished_product = Spree::WishedProduct.new(wished_product_params)

          if @wishlist.include? params[:wished_product][:variant_id]
            @wished_product = @wishlist.wished_products.detect { |wp| wp.variant_id == params[:wished_product][:variant_id].to_i }
            render_wished_product
          else
            @wished_product.wishlist = spree_current_user.wishlist
            if @wished_product.save
              render_wished_product
            else
              invalid_resource!(@wished_product)
            end
          end
        end

        def update
          authorize! :update, @wished_product
          if @wished_product.update(wished_product_attributes)
            render_wished_product
          else
            invalid_resource!(@wished_product)
          end
        end

        def destroy
          authorize! :destroy, @wished_product
          if @wished_product.destroy
            render json: { message: 'Successfully destroyed wished product ' }
          else
            render json: { error: 'Unable to destroy wished product ' }, status: 422
          end
        end

        private

          def wished_product_params
            params.require(:wished_product).permit(:variant_id, :wishlist_id, :remark, :quantity)
          end

          def load_wished_product
            unless @wished_product = Spree::WishedProduct.find(params[:id])
              render json: { errors: 'Wished Product not found' }, status: 404
            end
          end

          def load_default_wishlist
            unless @wishlist = spree_current_user.wishlist
              render json: { errors: 'Wishlist not found' }, status: 404
            end
          end

          def render_wished_product
            render json: @wished_product, serializer: Spree::WishedProductSerializer
          end
      end
    end
  end
end
