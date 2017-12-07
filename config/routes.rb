Rails.application.routes.draw do

  get 'friends/index'

  get 'friends/destroy'

  root to: 'static_pages#home'


  devise_for :users

  resources :users, only: [:show]
  get 'users/:id', to: 'users#show', as: 'user_profile'

  resources :friend_requests

end
