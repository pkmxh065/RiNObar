Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  namespace :admin do
    get "dashboard/index"
    root to: 'dashboard#index'
    resources :users, only: [:index, :destroy]
    resources :novels, only: [:index, :destroy]
  end
  root to: "homes#top"
  get "about" => "homes#about"
  resources :users, only: [:new, :create, :index, :show, :edit, :update] do
    get "unsubscribe", on: :collection
    patch "withdraw", on: :collection
    get "withdraw_done", on: :collection
  end
  resources :novels, only: [:new, :index, :show, :edit, :create, :update, :destroy]
  resources :posts, only: [:new, :index, :show, :edit, :create, :update, :destroy]
  devise_for :users
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
