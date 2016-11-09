Rails.application.routes.draw do

  namespace :admin do
  	root 'home#index'
    resources :users
    resources :provinces
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
