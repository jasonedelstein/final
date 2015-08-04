Rails.application.routes.draw do

  root 'item#index'

  resources :item
  
  post '/note'  => 'note#create'
  delete '/note/:id' => 'note#destroy'
  
end
