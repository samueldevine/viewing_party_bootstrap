Rails.application.routes.draw do
  root 'welcome#index'

  resources :users, only: [:create]

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/users/:id', to: 'users#dashboard'
  get '/users/:id/discover', to: 'users#discover'

  get '/users/:id/movies', to: 'movies#search'
  get '/users/:id/movies/:movie_id', to: 'movies#detail'

  get '/users/:id/movies/:movie_id/viewing-party/new', to: 'viewing_parties#new'
  post '/users/:id/movies/:movie_id/viewing-party', to: 'viewing_parties#create'
end
