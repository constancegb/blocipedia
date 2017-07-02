Rails.application.routes.draw do

  resources :wikis

  get 'welcome/index'

  root 'welcome#index'

  devise_for :users

end
