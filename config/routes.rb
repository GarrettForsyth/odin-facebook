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
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [:show, :index]
  resource :user, only: [:edit] do
    collection do
      patch 'update_avatar'
    end
  end
  resource :user, only: [:delete] do
    collection do
      delete 'delete_avatar'
    end
  end


  get 'users/:id', to: 'users#show', as: 'user_profile'
  resource :profile


  resources :friend_requests
  resources :notifications, only: [:index, :destroy]
  resources :posts, only: [:create, :new, :destroy, :index, :show]
  resources :comments, only: [:create, :new, :destroy]

end
