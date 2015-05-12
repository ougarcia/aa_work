Rails.application.routes.draw do

  resources :users, only: [:index, :create, :destroy, :show, :update] do
    resources :contacts, only: [:index]
    resources :comments, only: [:index, :create]
  end
  
  resources :contacts, only: [:destroy, :show, :update, :create] do
    resources :comments, only: [:index, :create]
  end

  resources :contact_shares, only: [:create, :destroy]
  resources :comments, only: [:update, :destroy]
end
