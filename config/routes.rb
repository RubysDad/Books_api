Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        post 'sign_up', to: 'registrations#create'
        post 'sign_in', to: 'sessions#create'
        delete 'sign_out', to: 'sessions#destroy'
      end

      get 'books/titles', to: 'books#index', scope: 'titles'

      resources :books, only: %w[index show] do
        resources :reviews, only: %w[index show create update destroy]
      end
    end

    namespace :v2 do
      resources :books, only: %w[index show]
    end
  end
end
