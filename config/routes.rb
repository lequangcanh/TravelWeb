Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :places, only: [:index, :show] do
    resources :place_comments, only: [:create, :destroy, :update]
  end

  devise_for :users
end
