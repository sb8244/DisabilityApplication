DisabilityApp::Application.routes.draw do
  root 'submissions#index'
  resources :submissions
  get 'professors/list' => 'professors#list', as: :list
  
  mount RailsEmailPreview::Engine, at: 'emails'
end
