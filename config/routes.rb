Rails.application.routes.draw do
  root to: "homes#top"
  get "about", to: "homes#about", as: "about"
  resources :users, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
    member do
      get :unsubscribe
      patch :withdraw
    end
    collection do
      get :withdraw_done
    end
  end
  resource :session
  resources :passwords, param: :token
  resources :novels, only: [:new, :index, :show, :edit, :create, :update, :destroy]
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
