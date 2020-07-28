Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :ppsps do
    resources :selected_installations, only: [ :create, :destroy ]
    resources :selected_altitudes, only: [ :create, :destroy ]
    resources :selected_risks, only: [ :create, :destroy ]
    member do
      get :ppsp_pdf
    end
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
  resources :subcontractors, only: [ :new, :create ]
  resources :sub_responsibles, only: [ :new, :create ]
  resources :hospitals, only: [ :new, :create ]
  resources :anti_poisons, only: [ :new, :create ]
  resources :sos_hands, only: [ :new, :create ]
  resources :deminings, only: [ :new, :create ]
  resources :work_medecines, only: [ :new, :create ]
  resources :direccts, only: [ :new, :create ]
  resources :pension_insurances, only: [ :new, :create ]
  resources :regional_committees, only: [ :new, :create ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
