Rails.application.routes.draw do

  # get "/index", to: "reservations#index"
  # post "/create", to: "reservations#create"
  
  root "welcome#home"

  namespace :api do
    namespace :v1 do
      resources :reservations, only: [:index, :create] do 
        member do
          patch 'pay'
        end
      end
    end
  end
end
