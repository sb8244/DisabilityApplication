DisabilityApp::Application.routes.draw do
  root 'submissions#index'
  resources :submissions do
    post :reschedule, on: :member
    post :email, on: :member
    get :all, on: :collection
  end
  get 'professors/list' => 'professors#list', as: :list

  get 'report/semester' => 'report#index', as: :semester_report
  post 'report/semester' => 'report#generate', as: :semester_report_generate
  
  mount RailsEmailPreview::Engine, at: 'emails'

  require 'sidekiq/web'
  require 'sidetiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
