Rails.application.routes.draw do
  devise_for :users
  
  resources :users do
    resources :resumes
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "resumes#index"
  
end
