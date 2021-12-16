Rails.application.routes.draw do
  root 'welcome#index'

  resources :users, only: [:create]

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'dashboard', to: 'users#dashboard'
  get '/discover', to: 'users#discover'

  get '/movies', to: 'movies#search'
  get '/movies/:movie_id', to: 'movies#detail'

  get '/movies/:movie_id/viewing-party/new', to: 'viewing_parties#new'
  post '/movies/:movie_id/viewing-party', to: 'viewing_parties#create'
end
