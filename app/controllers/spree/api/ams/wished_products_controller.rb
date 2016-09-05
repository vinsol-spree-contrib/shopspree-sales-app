module Spree
  module Api
    module Ams
      class WishedProductsController < Spree::Api::BaseController

        include Serializable
        include Requestable

        before_action :load_ams_user, only: :create
        before_action :load_default_wishlist, only: :create
        before_action :load_wished_product_by_variant, only: :create
        before_action :load_wished_product, only: [:update, :destroy]

        def create
          authorize! :create, WishedProduct
          @wished_product = @wishlist.wished_products.build(wished_product_params)
          if @wished_product.save
            render_wished_product
          else
            invalid_resource!(@wished_product)
          end
        end

        def update
          authorize! :update, @wished_product
          if @wished_product.update(wished_product_params)
            render_wished_product
          else
            invalid_resource!(@wished_product)
          end
        end

        def destroy
          authorize! :destroy, @wished_product
          if @wished_product.destroy
            render json: { message: t('.success') }
          else
            render json: { error: t('.failure') }, status: 422
          end
        end

        private

          def wished_product_params
            params.require(:wished_product).permit(:variant_id, :wishlist_id, :remark, :quantity)
          end

          def load_wished_product
            unless @wished_product = Spree::WishedProduct.find_by(id: params[:id])
              render json: { errors: Spree.t(:resource_not_found) }, status: 404
            end
          end

          def load_default_wishlist
            unless @wishlist = @user.wishlist
              render json: { errors: Spree.t(:resource_not_found) }, status: 404
            end
          end

          def render_wished_product
            render json: @wished_product, serializer: Spree::WishedProductSerializer
          end

          def load_wished_product_by_variant
            if @wished_product = @wishlist.wished_products.find_by(variant_id: params[:wished_product][:variant_id])
              render_wished_product
            end
          end
      end
    end
  end
end
