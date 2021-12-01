Rails.application.routes.draw do
  root 'welcome#index'

  resources :users, only: [:show, :create]

  get '/register', to: 'users#new'
  get '/users/:id/discover', to: 'users#discover'

  get '/users/:id/movies', to: 'movies#search'
  get '/users/:id/movies/:movie_id', to: 'movies#detail'

  get '/users/:id/movies/:movie_id/viewing-party/new', to: 'viewing_parties#new'
end
