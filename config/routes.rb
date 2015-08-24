Rails.application.routes.draw do

  get '/checkout' => 'checkout#index'
  post '/checkout' => 'checkout#create'
  delete '/checkout' => 'checkout#destroy'

  get '/sessions/new' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  
  get '/logout' => 'sessions#destroy'
  get '/account/:id' => 'users#show'
  
  post '/note'  => 'note#create'
  delete '/note/:id' => 'note#destroy'
  
  root 'item#index'
  
  post '/accessory' => 'item#create_accessory'
  resources :item
  
  patch '/users/promote/:id' => 'users#promote'
  post '/users/pay_fines' => 'users#pay_fines'
  
  resources :users
  
  end  