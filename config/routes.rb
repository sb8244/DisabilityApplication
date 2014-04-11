DisabilityApp::Application.routes.draw do
  root 'submissions#index'
  resources :submissions do
    post :reschedule, on: :member
    get :all, on: :collection
  end
  get 'professors/list' => 'professors#list', as: :list
  
  mount RailsEmailPreview::Engine, at: 'emails'

  require 'sidekiq/web'
  require 'sidetiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
