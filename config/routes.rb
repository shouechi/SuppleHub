Rails.application.routes.draw do
  devise_for :users, controllers: {
   sessions: "users/sessions",
   registrations: "users/registrations",
   passwords: "users/passwords"
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

  # Defines the root path route ("/")
  devise_scope :user do
    root "users/registrations#new"
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
