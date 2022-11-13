# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show] do
        resources :favorites, only: [:show]
      end
      resources :recipes, only: [:index]
      resources :learning_resources, only: [:index]
    end
  end
end
