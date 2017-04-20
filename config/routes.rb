Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  get 'users/new'

  get 'users/edit'

  get 'reservations/index'

  get 'reservations/show'

  get 'reservations/new'

  get 'reservations/edit'

  get 'restaurants/index'

  get 'restaurants/show'

  get 'restaurants/new'

  get 'restaurants/edit'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
