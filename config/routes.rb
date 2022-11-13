# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create] do
        resources :favorites, only: [:index]
      end
      resources :recipes, only: [:index]
      resources :learning_resources, only: [:index]
    end
  end
end
