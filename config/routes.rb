Rails.application.routes.draw do

  root 'game#index'

  resources :user
  resources :places

end
