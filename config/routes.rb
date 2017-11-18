Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  root 'home#index'
  
  resources :lists
  resources :products
  resources :contacts
  match '/upload', to: 'products#upload', via: :post
  match '/delete_price', to: 'products#delete_price', via: :get
  match '/remove_from_list', to: 'lists#remove_product', via: :delete
end
