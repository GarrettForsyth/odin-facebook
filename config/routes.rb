Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:show]
  get 'users/:id', to: 'users#show', as: 'user_profile'
  root to: 'static_pages#home'

end
