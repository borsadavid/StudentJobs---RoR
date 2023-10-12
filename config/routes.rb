Rails.application.routes.draw do
  devise_for :users
  resources :user_information, only: [:new,:update,:create,:destroy]

  get '/landing', to: 'home#landing'
  root to: "home#landing"
  
end
