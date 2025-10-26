Rails.application.routes.draw do
  # Auth
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Dashboard
  get '/dashboard', to: 'users#dashboard'

  # Listings
  resources :listings, only: [:index, :show, :create]

  # Messages
  resources :messages, only: [:index, :create]
  # Destroy
  resources :users, only: [:destroy]

end

