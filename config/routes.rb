Rails.application.routes.draw do

  mount Spree::Core::Engine, :at => '/'

  Spree::Core::Engine.routes.draw do
    namespace :api do
      namespace :ams do
        resource :home, controller: :home, only: :show
        resources :user_passwords, only: [:update, :create]
        resources :states, only: :index
        namespace :user do
          resources :profiles, only: :update, param: :token
          resources :confirmations, only: :create
          resources :addresses, only: [:index, :create, :update, :destroy]
        end

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
