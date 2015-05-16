Rails.application.routes.draw do
  root to: 'users#index'
  resources :users
  resource :session
  resources :subs

  resources :posts, except: :index
  resources :comments, only: [:update, :create, :destroy]
end
