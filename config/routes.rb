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

      resources :books, only: %w[index show] do
        get 'titles', to: 'books#review_titles', as: 'titles'
        resources :reviews, only: %w[index show create update destroy]
      end
    end
  end
end
