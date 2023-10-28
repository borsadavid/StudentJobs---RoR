Rails.application.routes.draw do
  devise_for :users
  resources :user_information, only: [:update, :create, :destroy]
  resources :cv, only: [:new, :create, :destroy, :index] do
    member do
      get 'configure_cv'
      post 'create_education'
      post 'create_experience'
      patch 'add_skills'
      patch 'update_experience'
      patch 'update_education'
      delete 'delete_experience'
      delete 'delete_education'
      get 'render_form'
      patch 'pdf_upload'
      patch 'upload_picture'
      delete 'delete_pdf'
      delete 'delete_picture'
    end
  end
  resources :skill, except: [:update, :edit]
  resources :company_information, only: [:destroy, :create, :update]
  resources :profile, only: [:index] do
    member do
      post 'apply_to_job'
      delete 'cancel_application'
    end
  end
  resources :job, except: [:new] do
    member do
      get 'render_create'
      get 'view_applications'
      get 'view_application_details'
    end
  end
  get '/feed', to: 'home#feed'
  get '/view_job/:id', to: 'home#view_job', as: 'view_job'
  root to: "home#feed"
  
end
