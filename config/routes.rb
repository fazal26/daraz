Rails.application.routes.draw do
  # routes added by Fazal Karim

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  resources :users do
    resources :products
  end
  resources :comments
  resources :charges

  get "/comment/:id/reply", to: "comment#reply", as: "reply"

  
  root to: 'application#landing_page'
  # ---------------------------
end
