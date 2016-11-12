Rails.application.routes.draw do

  namespace :admin do
  	root 'home#index'
    resources :users
    resources :provinces
    resources :places
    resources :hotels
    resources :restaurants
    resources :place_photos
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :places

  devise_for :users, :controllers => { registrations: 'registrations' }
end
