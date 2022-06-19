require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  root 'events#index'
  resources :events
  mount Sidekiq::Web => '/sidekiq'
end
