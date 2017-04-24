Rails.application.routes.draw do


  root 'home#index'

  # get "/restaurants/:id/reservations", to: "reservations#index", as: :restaurant_reservations

  resources :users
  resources :reservations, only: %i(new show create destroy index)
  resources :restaurants
  resources :sessions, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
