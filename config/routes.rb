Rails.application.routes.draw do

  root 'item#index'

  resources :item
  
  get '/checkout' => 'checkout#index'
  post '/checkout' => 'checkout#create'
  
  post '/note'  => 'note#create'
  delete '/note/:id' => 'note#destroy'
  
  resources :users do  
  get :autocomplete_user_name, on: :collection
end  
  
end
