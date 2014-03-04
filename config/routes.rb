DisabilityApp::Application.routes.draw do
  root 'submissions#index'
  resources :submissions do
    collection do
      get 'all'
    end
  end
  get 'professors/list' => 'professors#list', as: :list
  
  mount RailsEmailPreview::Engine, at: 'emails'

  require 'sidekiq/web'
  require 'sidetiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
