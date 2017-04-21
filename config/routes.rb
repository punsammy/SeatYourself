Rails.application.routes.draw do

  get '/' => 'home#index'

  resources :users
  resources :reservations
  resources :restaurants

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
