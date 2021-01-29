Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'database', to: 'pages#database', as: :database
  get 'contact', to: 'pages#contact', as: :contact
  
  # Ppsp
  resources :ppsps, except: [:destroy] do
    resources :subcontractors, only: [:create, :destroy]
    resources :selected_installations, only: [ :create, :destroy ]
    resources :selected_altitudes, only: [ :create, :destroy ]
    resources :selected_risks, only: [ :create, :destroy ]
    member do
      get 'destroy_annexe/:public_id', to: 'ppsps#destroy_annexe', as: :destroy_annexe 
      get :destroy_logo_client
      get :informations_supplementaires
      get :duplicate
    end
  end

  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :ppsps, only: [ :destroy, :index, :show ]
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


  resources :security_coordinators, except: [:new, :show, :destroy] do
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
