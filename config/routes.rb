Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :ppsps
  resources :companies, only: [ :new, :create ]
  resources :moas, only: [ :new, :create ]
  resources :moes, only: [ :new, :create ]
  resources :project_informations, only: [ :new, :create ]
  resources :site_managers, only: [ :new, :create ]
  resources :team_managers, only: [ :new, :create ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
