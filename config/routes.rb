Rails.application.routes.draw do

  resources :users
  resources :articles
  resources :roles
  resources :user_roles

  get    '/login',	to: 'sessions#new'
  post   '/login',	to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'articles#index'
  
  #config/routes.rb
  get    '/apitest',	to: 'articles#apitest'
  get    '/apitest2',	to: 'articles#apitest2'
 end
