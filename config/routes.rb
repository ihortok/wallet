Rails.application.routes.draw do
  devise_for :users
  root to: 'welcome_page#index'
  get '/about', to: 'about_page#index'
  get '/profile', to: 'profiles#show'
  get '/profile/edit', to: 'profiles#edit'
  post '/profile/update', to: 'profiles#update'
  resources :accounts
  resources :operations
end
