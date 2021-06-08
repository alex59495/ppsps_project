Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'database', to: 'pages#database', as: :database
  get 'contact', to: 'pages#contact', as: :contact
  
  # Ppsp
  resources :ppsps do
    delete 'destroy_annexe/:public_id', to: 'ppsps#destroy_annexe', as: :destroy_annexe 
    resources :steps, only: [:show, :update], controller: 'steps_controllers/ppsps_steps'
    get 'wizard_update_end', to: 'steps_controllers/ppsps_steps#wizard_update_end', as: :wizard_update_end
    resources :selected_installations, only: [ :create, :destroy ]
    resources :selected_altitudes, only: [ :create, :destroy ]
    resources :selected_risks, only: [ :create, :destroy ]
    resources :selected_subcontractors, only: [ :create, :destroy ]
    member do
      get 'destroy_plan_installation/:public_id', to: 'ppsps#destroy_plan_installation', as: :destroy_plan_installation
      get :destroy_logo_client
      get :duplicate
    end
  end

  delete 'destroy_logo_client/:public_id', to: 'ppsps#destroy_logo_client', as: :destroy_logo_client

  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :ppsps, only: [ :destroy, :index, :show ]
      
      get 'list_subcontractors', to: 'subcontractors#list_subcontractors'
      get 'selected_subcontractors', to: 'subcontractors#selected_subcontractors'     
      delete 'selected_subcontractors/:subcontractor_id', to: 'subcontractors#destroy_selected_subcontractors'
      
      resources :risks, only: [ :index ]
      get 'selected_risks', to: 'risks#selected_risks'
      delete 'selected_risks/:risk_id', to: 'risks#destroy_selected_risks'
      
      resources :altitude_works, only: [ :index ]
      delete 'selected_altitudes/:altitude_id', to: 'altitude_works#destroy_selected_altitudes'
      get 'selected_altitude_works', to: 'altitude_works#selected_altitude_works'
      
      resources :site_installations, only: [ :index ]
      get 'selected_site_installations', to: 'site_installations#selected_site_installations'
      delete 'selected_installations/:installation_id', to: 'site_installations#destroy_selected_installations'
      
      resources :conductors, only: [:index, :destroy, :show]      
      resources :machines, only: [ :index ]
      get 'machines/categories', to: 'machines#categories'
      post 'conductors/:machine_id/:worker_id', to: 'conductors#create', as: :create_conductor
      get 'workers/conductors', to: 'workers#conductors'
      get 'workers/lifesavers', to: 'workers#lifesavers'
      get 'workers/selected_lifesavers', to: 'workers#selected_lifesavers'
      delete 'selected_lifesavers/:lifesaver_id', to: 'workers#destroy_selected_lifesavers'
    end
  end

  # Utilisateurs
  resources :profiles, only: [:show, :edit, :update]

  # Database
  resources :kit_security_elements, only: [:create, :destroy]

  resources :companies, only: [:edit, :update] do
    member do
      get :destroy_logo
      get :destroy_cover
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
