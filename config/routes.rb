Rails.application.routes.draw do
  # routes added by Fazal Karim

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  resources :users 
  resources :products do
    resources :comments
  end
  resources :charges
  get "/comment/:id/reply", to: "comment#reply", as: "reply"
  root to: 'products#index'
end
