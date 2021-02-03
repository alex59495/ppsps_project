Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'database', to: 'pages#database', as: :database
  get 'contact', to: 'pages#contact', as: :contact
  
  # Ppsp
  resources :ppsps, except: [:destroy] do
    resources :selected_installations, only: [ :create, :destroy ]
    resources :selected_altitudes, only: [ :create, :destroy ]
    resources :selected_risks, only: [ :create, :destroy ]
    resources :selected_subcontractors, only: [ :create, :destroy ]
    member do
      get 'destroy_annexe/:public_id', to: 'ppsps#destroy_annexe', as: :destroy_annexe 
      get :destroy_logo_client
      get :duplicate
    end
  end

  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :ppsps, only: [ :destroy, :index, :show ]
      resources :machines, only: [ :index ]
      resources :subcontractors, only: [ :index, :destroy ]
      get 'selected_subcontractors', to: 'subcontractors#selected_subcontractors'
      resources :risks, only: [ :index, :destroy ]
      get 'selected_risks', to: 'risks#selected_risks'
      resources :altitude_works, only: [ :index, :destroy ]
      get 'selected_altitude_works', to: 'altitude_works#selected_altitude_works'
      resources :site_installations, only: [ :index, :destroy ]
      get 'selected_site_installations', to: 'site_installations#selected_site_installations'
      resources :conductors, only: [:index, :destroy]
      post 'conductor/:machine_id/:worker_id', to: 'conductors#create'

      resources :workers, only: [:destroy]
      get 'workers/conductors', to: 'workers#conductors'
      get 'workers/lifesavers', to: 'workers#lifesavers'
      get 'workers/selected_lifesavers', to: 'workers#selected_lifesavers'
    end
  end

  # Utilisateurs
  resources :profiles, only: [:show, :edit, :update]

  # Database
  resources :companies, only: [:update] do
    member do      
      get :destroy_logo
    end
  end

  resources :subcontractors, except: [:new, :show, :destroy] do
    member do
      post :destroyed, as: :destroy
    end
    collection do
      get :pagination, as: :pagination
    end
  end

  resources :risks, except: [:new, :show, :destroy] do
    member do
      post :destroyed, as: :destroy
    end
    collection do
      get :pagination, as: :pagination
    end
  end


  resources :security_coordinators, except: [:new, :show, :destroy] do
    member do
      post :destroyed, as: :destroy
    end
    collection do
      get :pagination, as: :pagination
    end
  end

  resources :workers, except: [:new, :show, :destroy] do
    member do
      post :destroyed, as: :destroy
    end
    collection do
      get :pagination, as: :pagination
    end
  end

  resources :moas, except: [:new, :show, :destroy] do
    member do
      post :destroyed, as: :destroy
    end
    collection do
      get :pagination, as: :pagination
    end
  end

  resources :moes, except: [:new, :show, :destroy] do
    member do
      post :destroyed, as: :destroy
    end
    collection do
      get :pagination, as: :pagination
    end
  end

  resources :hospitals, except: [:new, :show, :destroy] do
    member do
      post :destroyed, as: :destroy
    end
    collection do
      get :pagination, as: :pagination
    end
  end

  resources :anti_poisons, except: [:new, :show, :destroy] do
    member do
      post :destroyed, as: :destroy
    end
    collection do
      get :pagination, as: :pagination
    end
  end

  resources :sos_hands, except: [:new, :show, :destroy] do
    member do
      post :destroyed, as: :destroy
    end
    collection do
      get :pagination, as: :pagination
    end
  end

  resources :deminings, except: [:new, :show, :destroy] do
    member do
      post :destroyed, as: :destroy
    end
    collection do
      get :pagination, as: :pagination
    end
  end

  resources :work_medecines, except: [:new, :show, :destroy] do
    member do
      post :destroyed, as: :destroy
    end
    collection do
      get :pagination, as: :pagination
    end
  end

  resources :direccts, except: [:new, :show, :destroy] do
    member do
      post :destroyed, as: :destroy
    end
    collection do
      get :pagination, as: :pagination
    end
  end

  resources :pension_insurances, except: [:new, :show, :destroy] do
    member do
      post :destroyed, as: :destroy
    end
    collection do
      get :pagination, as: :pagination
    end
  end

  resources :regional_committees, except: [:new, :show, :destroy] do
    member do
      post :destroyed, as: :destroy
    end
    collection do
      get :pagination, as: :pagination
    end
  end

  # Pages d'erreur
  get '/404', to: "errors#not_found"
  get '/422', to: "errors#unacceptable"
  get '/500', to: "errors#internal_error"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
