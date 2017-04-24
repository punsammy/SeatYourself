Rails.application.routes.draw do

<<<<<<< HEAD
  root 'home#index'

  get "/restaurants/:id/reservations", to: "reservations#index", as: :restaurant_reservations

=======
  get '/' => 'home#index'
>>>>>>> user
  resources :users
  resources :reservations, only: %i(new show create destroy)
  resources :restaurants
  resources :sessions, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
