Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts
  resources :interests, only: [:index]
  resources :comments, only: [:create, :destroy]
  resources :users, only: [:index, :create, :show]
end
