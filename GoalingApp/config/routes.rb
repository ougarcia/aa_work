Rails.application.routes.draw do
  root 'static_pages#home'
  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :new, :destroy]
  resources :goals, only: [:create, :new, :update, :index, :show]
end
