Rails.application.routes.draw do
  # Endpoints αυθεντικοποίησης
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  resources :todos do
    resources :items
  end
end