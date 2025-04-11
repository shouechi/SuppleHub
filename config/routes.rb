Rails.application.routes.draw do
  devise_for :users, controllers: {
   sessions: "users/sessions",
   registrations: "users/registrations",
   passwords: "users/passwords",
   omniauth_callbacks: "users/omniauth_callbacks"
 }

  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  resources :posts do
    resources :comments, only: %i[ create destroy ]
    collection do
      get :autocomplete
    end
  end
  resources :supplecategories

  resources :users, only: %i[ show ]

  resources :notifications, only: %i[ index destroy ] do
    collection do
      delete :destroy_all
    end
  end

  resources :diagnoses, only: %i[ new create ]

  get "static_pages/privacy_policy"
  get "static_pages/terms"
  root "static_pages#top"

  # Defines the root path route ("/")

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
