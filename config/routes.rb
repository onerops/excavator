Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :tickets, only: [:index,:show]
  root to: "main#index"


  namespace :api do 
    namespace :v1 do 
      resources :tickets, only: [:create]
    end
  end

end
