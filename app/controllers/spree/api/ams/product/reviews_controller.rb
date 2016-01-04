module Spree
  module Api
    module Ams
      module Product
        class ReviewsController < Spree::Api::BaseController
          include Serializable
          include Requestable

          before_action :load_ams_user, only: [:create, :destroy]
          before_action :load_product, only: [:create, :index]
          before_action :load_review, only: :destroy

          def index
            @reviews = @product.reviews.approved.page(params[:page] || 1).per(params[:per_page] || 20)
            render json: @reviews,
              each_serializer: Spree::ReviewSerializer,
              meta: [:avg_rating, :reviews_count, :reviews_with_content_count, :ratings_distribution].inject({}) { |meta_hash, method| meta_hash[method] = @product.send(method); meta_hash }
          end

          def create
            @review = @product.reviews.build(review_params)
            @review.locale = I18n.locale.to_s if Spree::Reviews::Config[:track_locale]
            authorize! :create, @review
            if @review.save
              render json: @review, serializer: Spree::ReviewSerializer
            else
              invalid_resource!(@review)
            end
          end

          def destroy
            authorize! :destroy, @review
            if @review.destroy
              render json: { message: 'Successfully destroyed review ' }
            else
              render json: { error: 'Unable to destroy review ' }, status: 422
            end
          end

          private

           def load_product
              unless @product = Spree::Product.find_by(id: params[:product_id])
                render json: { errors: 'Product not found' }, status: 404
              end
            end

            def load_review
              unless @review = Spree::Review.find_by(id: params[:review_id])
                render json: { errors: 'Review not found' }, status: 404
              end
            end

            def review_params
              params.require(:review).permit(:name, :location, :rating, :title, :review, :ip_address).merge(user_id: @user.id)
            end

        end
      end
    end
  end
end
