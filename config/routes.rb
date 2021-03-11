Rails.application.routes.draw do
  resources :reservations, only: [:index, :create]

  root to: 'reservations#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
