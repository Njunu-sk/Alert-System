Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :alerts, only: [:create, :index]
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
