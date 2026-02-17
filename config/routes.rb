Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Endpoints αυθεντικοποίησης
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  get 'auth/logout', to: 'authentication#logout'

  resources :todos do
    resources :items
  end
end