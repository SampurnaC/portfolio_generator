Rails.application.routes.draw do
  devise_for :users
  
  resources :users do
    resources :resumes do
      collection do
        get :my_resumes
      end
    resources :payments, only: [:new, :create]

    end
  end

  get 'payment_success', to: 'payments#success'
  get 'payment_failure', to: 'payments#failure'
  get "up" => "rails/health#show", as: :rails_health_check

  root "resumes#index"
  
end
