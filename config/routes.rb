Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }, skip: [:registrations]
  devise_scope :user do
    get 'sign_up', to: 'users/registrations#new', as: :new_user_registration
    post 'users', to: 'users/registrations#create', as: :create_user_registration
  end
  root "tops#index"

  resources :users do
    resources :likes, only: [:create, :destroy]
  end
  
  delete "users/:id/destroy", to: "users#destroy", as: :destroy_user
  get "users/:id/cancel_membership", to: "users#cancel_membership", as: :cancel_membership_user
  get 'matching_users', to: 'users#matching_users', as: :matching_users
  
  get 'user_informations/new', to: 'user_informations#new', as: :new_user_information
  post 'user_informations/create', to: 'user_informations#create', as: :create_user_information


end
  