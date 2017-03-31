Rails.application.routes.draw do

  resources :wikis

  resources :charges, only: [:create, :destroy]

  resources :collaborators, only: [:create, :destroy]

  devise_for :users, controllers: { registrations: 'users/registrations' }

  authenticated :user do
    root 'wikis#index', as: :authenticated_root
  end

  root to: 'home#index'

end
