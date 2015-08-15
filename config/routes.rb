Rails.application.routes.draw do

  root 'item#index'
  
  resources :item
  resources :users
  
  get '/sessions/new' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/account/:id' => 'users#show'
  
  get '/checkout' => 'checkout#index'
  post '/checkout' => 'checkout#create'
  
  post '/note'  => 'note#create'
  delete '/note/:id' => 'note#destroy'

  end  