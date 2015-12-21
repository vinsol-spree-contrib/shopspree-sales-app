Rails.application.routes.draw do

  mount Spree::Core::Engine, :at => '/'

  Spree::Core::Engine.routes.draw do
    namespace :api do
      namespace :ams do
        resource :home, controller: :home, only: :show
        resources :user_passwords, only: [:update, :create]
        resources :states, only: :index
        namespace :product do
          resources :reviews, only: [:index, :create, :destroy], param: :review_id
        end
        namespace :user do
          resources :profiles, only: :update, param: :token
          resources :confirmations, only: :create
          resources :addresses, only: [:index, :create, :update, :destroy], param: :address_id
        end

        get "/orders/current", to: "orders#current", as: "current_order"
        get "/orders/mine", to: "orders#mine", as: "my_orders"

        scope '/users' do
          resources :credit_cards, only: [:index, :create, :destroy]
        end

        concern :order_routes do
          resources :line_items
          resources :payments, only: [:new, :create, :index]
        end

        resources :orders, concerns: :order_routes
        resources :checkouts, only: [:update], concerns: :order_routes

        post '/users/sign_in', to: 'users#token'
        patch '/password/change', to: 'user_passwords#update'
        post '/password/reset', to: 'user_passwords#create'
      end
    end

    namespace :admin do
      resources :banners
      resources :product_property_types
      resources :filters
    end
  end

end
