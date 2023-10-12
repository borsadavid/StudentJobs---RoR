Rails.application.routes.draw do
  devise_for :users
  resources :user_information

  get '/landing', to: 'home#landing'
  root to: "home#landing"
  
end
