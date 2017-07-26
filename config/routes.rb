Rails.application.routes.draw do

  resources :wikis do
     resources :collaborators, only: [:index, :new, :create, :destroy]
  end

  get 'welcome/index'

  root 'welcome#index'

  devise_for :users

  resources :charges, only: [:new, :create]
  resources :downgrade, only: [:new, :create]

end
