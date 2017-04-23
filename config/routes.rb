Rails.application.routes.draw do

  get '/' => 'home#index'
  resources :users
  resources :reservations
  resources :restaurants
  resources :sessions, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
