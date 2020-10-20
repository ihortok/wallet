Rails.application.routes.draw do
  devise_for :users
  root to: 'welcome_page#index'
  resources :accounts
  resources :operations
end
