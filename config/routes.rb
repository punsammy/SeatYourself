Rails.application.routes.draw do

<<<<<<< HEAD
  root 'home#index'


=======
  get '/' => 'home#index'
>>>>>>> user
  resources :users
  resources :reservations
  resources :restaurants
  resources :sessions, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
