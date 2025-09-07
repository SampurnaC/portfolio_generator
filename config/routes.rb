Rails.application.routes.draw do
  devise_for :users
  
  resources :users do
    resources :portfolios
  end

  get "up" => "rails/health#show", as: :rails_health_check

  
end
