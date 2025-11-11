Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }, skip: [:registrations]
  devise_scope :user do
    post 'users', to: 'users/registrations#create', as: :create_user_registration
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "tops#index"
  resources :users
  post "users/create", to: "users#create", as: :create_new_user
  get "users/:id/destroy", to: "users#destroy", as: :destroy_user

  post "user_informations/new", to: "user_informations#new", as: :new_user_information
  post "user_informations/create", to: "user_informations#create", as: :create_user_information
end
