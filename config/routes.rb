Rails.application.routes.draw do

  resources :wikis

  get 'welcome/index'

  root 'welcome#index'

  devise_for :users

  resources :charges, only: [:new, :create]
  resources :downgrade, only: [:new, :create]

end
