Rails.application.routes.draw do
  resources :moments
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :moments
      post '/sign-up', to: 'users#create', as: :user_sign_up
      post '/sign-in', to: 'sessions#create', as: :user_login
    end
  end
end
