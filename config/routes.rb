Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    
  resources :users, only: [:create, :show, :index, :update, :destroy]
  resources :tools, only: [:create, :show, :index, :update, :destroy]
  
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:update] do
    member do
      patch :upload_profile_image
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get '/rails/active_storage/*path', to: 'active_storage/blobs#show'
end
