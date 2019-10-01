Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  resources :users 
  resources :charges
  resources :products do
    resources :comments
    collection do
      get :autocomplete
    end 
  end
  
  root to: 'products#index'
end
