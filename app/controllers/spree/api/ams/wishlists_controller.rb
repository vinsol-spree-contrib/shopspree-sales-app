module Spree
  module Api
    module Ams
      class WishlistsController < Spree::Api::BaseController

        include Serializable
        include Requestable

        before_action :load_ams_user, only: [:index, :create, :update, :destroy, :default]
        before_action :load_wishlist, only: [:update, :destroy, :show]
        before_action :load_default_wishlist, only: :default

        def index
          render json: @user.wishlists, each_serializer: Spree::WishlistSerializer, root: false
        end

        def create
          authorize! :create, Wishlist
          @wishlist = @user.wishlists.build(wishlist_params)
          if @wishlist.save
            render_wishlist
          else
            invalid_resource!(@wishlist)
          end
        end

        def update
          authorize! :update, @wishlist
          if @wishlist.update(wishlist_params)
            render_wishlist
          else
            invalid_resource!(@wishlist)
          end
        end

        def destroy
          authorize! :destroy, @wishlist
          if @wishlist.destroy
            render json: { message: t('.success') }
          else
            render json: { error: t('.failure') }, status: 422
          end
        end

        def show
          render_wishlist
        end

        def default
          render_wishlist
        end

        private

          def wishlist_params
            params.require(:wishlist).permit(:name, :is_default, :is_private)
          end

          def load_wishlist
            unless @wishlist = @user.wishlists.find_by_access_hash!(params[:id])
              render json: { errors: Spree.t(:resource_not_found) }, status: 404
            end
          end

          def load_default_wishlist
            unless @wishlist = @user.wishlist
              render json: { errors: Spree.t(:resource_not_found) }, status: 404
            end
          end

          def render_wishlist
            render json: @wishlist, serializer: Spree::WishlistSerializer
          end
      end
    end
  end
end
