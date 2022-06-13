Rails.application.routes.draw do
  root 'static_pages#home'
  
  get '/admin', to: 'admins#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  resources :microposts
  resources :users
  namespace :admin do
    resources :foods
  end
  resources :password_resets, only: [:new, :create, :edit, :update]

end
