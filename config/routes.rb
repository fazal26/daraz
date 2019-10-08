Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "registrations" } 

  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  namespace :admin do
    resources :products, only: [:index]
    resources :coupons
    resources :promotions
    resources :users, only: [:index, :destroy]
    resources :dashboard, only: [:index]
  end

  namespace :seller do 
    resources :products do
      resources :comments
      collection do
        get :autocomplete
      end 
    end
  end

  resources :products, only: [:index, :show] do  
    collection do
      get :autocomplete
    end 
    resources :comments
  end

  resources :users
  resource :cart, controller: :cart, only: [:show, :destroy]  
  resources :line_items, only: [:create, :destroy, :update]
  resources :orders, only: [:index] do 
    collection do 
      post :apply_coupon, as: :coupon
      get :pending_order, as: :pending
    end
  end
  resources :charges, only: [:create]
  
  get '*path' => redirect('/')
  root to: 'products#index'
end
