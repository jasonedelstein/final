Rails.application.routes.draw do

  root 'item#index'

  resources :item

end
