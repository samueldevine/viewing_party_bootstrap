Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/users/:user_id', to: 'users#show'
end
