Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  root "lists#index"

  resources :lists do
    resources :bookmarks, only: [:new, :index, :create]
    resources :reviews, only: [:new, :index, :create]
  end
  resources :reviews, only: [:destroy, :edit, :update]
  resources :bookmarks, only: [:destroy, :edit, :update]
end
