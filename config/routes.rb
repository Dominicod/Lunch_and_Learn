# frozen_string_literal: true

Rails.application.routes.draw do
  post '/api/v1/users/login', to: 'api/v1/users#login'
  post '/api/v1/users/logout', to: 'api/v1/users#logout'

  namespace :api do
    namespace :v1 do
      resources :favorites, only: %i[index create]
      resources :users, only: [:create]
      resources :recipes, only: [:index]
      resources :learning_resources, only: [:index]
      resources :tourist_sights, only: [:index]
    end
  end
end
