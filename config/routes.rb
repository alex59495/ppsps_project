Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'database', to: 'pages#database', as: :database
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
  resources :companies, only: [ :new, :create, :index ]
  resources :moas, only: [ :new, :create, :index ]
  resources :moes, only: [ :new, :create, :index ]
  resources :project_informations, only: [ :new, :create, :index ]
  resources :site_managers, only: [ :new, :create, :index ]
  resources :team_managers, only: [ :new, :create, :index ]
  resources :subcontractors, only: [ :new, :create, :index ]
  resources :sub_responsibles, only: [ :new, :create, :index ]
  resources :hospitals, only: [ :new, :create, :index ]
  resources :anti_poisons, only: [ :new, :create, :index ]
  resources :sos_hands, only: [ :new, :create, :index ]
  resources :deminings, only: [ :new, :create, :index ]
  resources :work_medecines, only: [ :new, :create, :index ]
  resources :direccts, only: [ :new, :create, :index ]
  resources :pension_insurances, only: [ :new, :create, :index ]
  resources :regional_committees, only: [ :new, :create, :index ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
