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
  resources :hotels

  resources :places, only: [:index, :show] do
    resources :place_comments, only: [:create, :destroy, :update]
  end


  devise_for :users, :controllers => { registrations: 'registrations' }
end
