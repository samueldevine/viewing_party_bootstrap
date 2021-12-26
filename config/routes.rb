Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/dashboard', to: 'users#dashboard'
  get '/discover', to: 'users#discover'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/movies', to: 'movies#search'
  get '/movies/:movie_id', to: 'movies#detail'

  get '/movies/:movie_id/viewing-party/new', to: 'viewing_parties#new'
  post '/movies/:movie_id/viewing-party', to: 'viewing_parties#create'
end
