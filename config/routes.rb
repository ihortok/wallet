Rails.application.routes.draw do
  devise_for :users
  root to: 'welcome_page#index'
  get '/about', to: 'about_page#index'
  resources :accounts
  resources :operations
end
