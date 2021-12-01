Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  resources :users, only: [:new, :show, :create]

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/users/:user_id', to: 'users#show'
  get '/users/:id/discover', to: 'users#discover'

  post '/users/:id/movies', to: 'movies#search'
end
