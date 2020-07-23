Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :ppsps do
    resources :selected_installations, only: [ :create, :destroy ]
    resources :selected_altitudes, only: [ :create, :destroy ]
    resources :selected_risks, only: [ :create, :destroy ]
    member do
      get :informations_supplementaires
    end
  end
  resources :companies, only: [ :new, :create ]
  resources :moas, only: [ :new, :create ]
  resources :moes, only: [ :new, :create ]
  resources :project_informations, only: [ :new, :create ]
  resources :site_managers, only: [ :new, :create ]
  resources :team_managers, only: [ :new, :create ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
