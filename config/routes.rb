require 'sidekiq/web'

Rails.application.routes.draw do
  root 'events#index'
  resources :events
  mount Sidekiq::Web => '/sidekiq'
end
