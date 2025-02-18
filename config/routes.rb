Rails.application.routes.draw do
  get "library_books/index"
  get "library_books/show"
  get "library_books/new"
  get "library_books/create"
  get "library_books/edit"
  get "library_books/update"
  get "library_books/destroy"
  get "borrowings/create"
  get "borrowings/destroy"
  get "user/create"
  resource :session
  resources :user, only: %i[new create]
  resources :passwords, param: :token
  resources :library_books
  resources :borrowings, only: %i[create destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  #
  #
  delete "logout", to: "sessions#destroy", as: :destroy_session
  delete "library_book/:id", to: "library_books#destroy", as: :destroy_library_book
  post "/borrowings/:library_book_id", to: "borrowings#create", as: :create_borrowings
  delete "signup", to: "user#create"
  get "dashboard", to: "library_books#index"
  get "profile", to: "pages#profile"
  # Defines the root path route ("/")
  root "pages#home"
end
