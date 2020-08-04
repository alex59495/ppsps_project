Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'database', to: 'pages#database', as: :database
  resources :ppsps do
    resources :subcontractors do
      member do
        get :modal
      end
    end
    resources :selected_installations, only: [ :create, :destroy ]
    resources :selected_altitudes, only: [ :create, :destroy ]
    resources :selected_risks, only: [ :create, :destroy ]
    resources :selected_subcontractors, only: [ :create, :destroy ]
    member do
      get :ppsp_pdf
    end
    member do
      get :informations_supplementaires
    end
  end
  resources :companies
  resources :security_coordinators
  resources :moas
  resources :moes
  resources :project_informations
  resources :site_managers
  resources :team_managers
  resources :hospitals
  resources :anti_poisons
  resources :sos_hands
  resources :deminings
  resources :work_medecines
  resources :direccts
  resources :pension_insurances
  resources :regional_committees
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
