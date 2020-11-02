Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'database', to: 'pages#database', as: :database
  resources :ppsps do
    resources :subcontractors, only: [:create] do
      member do
        get :modal
      end
    end
    resources :selected_installations, only: [ :create, :destroy ]
    resources :selected_altitudes, only: [ :create, :destroy ]
    resources :selected_risks, only: [ :create, :destroy ]
    resources :selected_subcontractors, only: [ :create, :destroy ]
    member do
      get :informations_supplementaires
    end
  end
  resources :subcontractors, except: [:create]
  resources :companies
  resources :security_coordinators
  resources :moas, except: [:new]
  resources :moes, except: [:new]
  resources :project_informations
  resources :site_managers
  resources :team_managers
  resources :hospitals, except: [:new]
  resources :anti_poisons, except: [:new]
  resources :sos_hands, except: [:new]
  resources :deminings, except: [:new]
  resources :work_medecines
  resources :direccts, except: [:new]
  resources :pension_insurances, except: [:new]
  resources :regional_committees, except: [:new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
