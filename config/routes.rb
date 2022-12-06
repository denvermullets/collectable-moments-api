Rails.application.routes.draw do
  resources :moments
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :moments
    end
  end
end
