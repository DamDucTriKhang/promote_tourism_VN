Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  resources :microposts
  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
end
