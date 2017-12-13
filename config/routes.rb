Rails.application.routes.draw do

  get 'posts/create'

  get 'posts/destroy'

  get 'posts/index'

  get 'friends/index'

  delete 'friends/destroy'

  post '/like_post', to: 'posts#like'
  post '/unlike_post', to: 'posts#unlike'
  post '/dislike_post', to: 'posts#dislike'
  post '/undislike_post', to: 'posts#undislike'


  post '/like_comment', to: 'comments#like'
  post '/unlike_comment', to: 'comments#unlike'
  post '/dislike_comment', to: 'comments#dislike'
  post '/undislike_comment', to: 'comments#undislike'

  root to: 'static_pages#home'

  devise_for :users

  resources :users, only: [:show, :index]
  get 'users/:id', to: 'users#show', as: 'user_profile'

  resources :friend_requests
  resources :notifications, only: [:destroy]
  resources :posts, only: [:create, :new, :destroy, :index]
  resources :comments, only: [:new, :create, :destroy]

end
