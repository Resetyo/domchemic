Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  root 'home#index'
  
  resources :products
  match '/upload', to: 'products#upload', via: :post
end
