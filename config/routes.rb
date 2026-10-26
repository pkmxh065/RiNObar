Rails.application.routes.draw do
  root to: "homes#top"
  get "about", to: "homes#about", as: "about"
  namespace :admin do
    get "login", to: "sessions#new", as: "login"
    post "login", to: "sessions#create"
    post "/", to: "sessions#create"
    delete "logout", to: "sessions#destroy", as: :logout
    root to: "sessions#new"

    get "dashboard", to: "dashboard#index", as: "dashboard"
    resources :users, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :show, :destroy]
  end
  resource :session
  resources :passwords, param: :token
  resources :users, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
    member do
      get :unsubscribe
      patch :withdraw
    end
    collection do
      get :withdraw_done
    end
  end
  resources :novels, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  get "search", to: "searches#search"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
