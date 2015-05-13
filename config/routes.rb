Rails.application.routes.draw do
  resources :cats do
    resources :cat_rental_requests, only: [:index, :new]
  end

  resources :cat_rental_requests, only: [:show, :destroy, :create, :new] do
    member do
      patch 'approve'
      patch 'deny'
    end
  end

end
