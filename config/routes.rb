Rails.application.routes.draw do
  root 'application#index'
  resources :search, only: :index
end
