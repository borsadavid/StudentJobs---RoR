Rails.application.routes.draw do
  devise_for :users
  resources :user_information, only: [:new, :update, :create, :destroy]
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
    end
  end
  resources :skill, except: [:update]

  get '/landing', to: 'home#landing'
  root to: "home#landing"
  
end
