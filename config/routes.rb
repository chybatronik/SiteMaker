SiteMaker::Application.routes.draw do
  resources :sites

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  get "create", to:"jekyll#create", as:"create_jekyll"
end
