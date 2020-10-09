Rails.application.routes.draw do
  resources :accounts
  devise_for :users
  root to: 'welcome_page#index'
end
