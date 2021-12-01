Rails.application.routes.draw do
  root 'welcome#index'

  resources :users, only: [:show, :create]

  get '/register', to: 'users#new'
  get '/users/:id/discover', to: 'users#discover'

  get '/users/:id/movies', to: 'movies#search'
end
