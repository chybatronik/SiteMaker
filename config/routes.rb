SiteMaker::Application.routes.draw do

  resources :sites do
    resources :pages, controller: "pages"
  end

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end
