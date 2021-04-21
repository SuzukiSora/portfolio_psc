Rails.application.routes.draw do
  
  # get 'relationships/create'
  # get 'relationships/destroy'
  # get 'posts/index'
  # get 'users/index'
  # get 'users/show'
  # get 'likes/create'
  # get 'likes/destroy'
  root to: 'toppages#index' do
    member do 
      get :followings
      get :followers

      get :likes
    end
  end

  devise_for :users

  resources :users, only: [:index, :show, :edit, :update] do
    member do 
      get :followings
      get :followers

      get :likes
    end
  end
  
  resources :posts, only: [:index, :new, :show, :update, :edit, :create] do
    resources :likes, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]

  
end
