Rails.application.routes.draw do

  get 'friends/index'

  delete 'friends/destroy'

  root to: 'static_pages#home'


  devise_for :users

  resources :users, only: [:show, :index]
  get 'users/:id', to: 'users#show', as: 'user_profile'

  resources :friend_requests

  resources :notifications, only: [:destroy]

end
