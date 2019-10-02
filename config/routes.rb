Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  resources :users 
  resources :products do
    resources :comments
    collection do
      get :autocomplete
    end 
  end

  resources :line_items, only: [:create, :destroy, :update]
  resource :cart, controller: :cart, only: [:show] do
    collection do
      patch :clear
    end
  end

  resources :orders
  resources :charges
  resources :coupons
  
  root to: 'products#index'
end
