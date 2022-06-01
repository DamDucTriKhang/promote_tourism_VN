Rails.application.routes.draw do
  root 'static_pages#home'
  resources :microposts
  resources :posts
end
