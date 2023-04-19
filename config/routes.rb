# frozen_string_literal: true

Rails.application.routes.draw do
  resources :videos
  resources :users
  resources :sesions

  root 'videos#index'
  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/share-video', to: 'videos#new', as: 'share_video'
  post '/share-video', to: 'videos#create'
end
