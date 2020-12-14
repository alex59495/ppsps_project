Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'database', to: 'pages#database', as: :database

  # Ppsp
  resources :ppsps, except: [:destroy] do
    resources :subcontractors, only: [:create, :destroy]
    resources :selected_installations, only: [ :create, :destroy ]
    resources :selected_altitudes, only: [ :create, :destroy ]
    resources :selected_risks, only: [ :create, :destroy ]
    member do
      get :informations_supplementaires
    end
  end

  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :ppsps, only: [ :destroy, :index, :show ]
    end
  end

  resources :companies, only: [:create, :destroy]
  resources :security_coordinators, except: [:new, :show]
  resources :moas, except: [:new, :show]
  resources :moes, except: [:new, :show]
  resources :hospitals, except: [:new, :show]
  resources :anti_poisons, except: [:new, :show]
  resources :sos_hands, except: [:new, :show]
  resources :deminings, except: [:new, :show]
  resources :work_medecines, except: [:new, :show]
  resources :direccts, except: [:new, :show]
  resources :pension_insurances, except: [:new, :show]
  resources :regional_committees, except: [:new, :show]
  resources :profiles, only: [:show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
