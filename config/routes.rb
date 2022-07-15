Rails.application.routes.draw do

  get "/index", to: "reservations#index"
  post "/create", to: "reservations#create"
  get "/even", to: "tickets#make_even"
  get "/reservation_list", to: "reservation#get_reserved_tickets"
  
  root "welcome#home"

  resources :reservations do
    member do
      patch 'reserve'
      patch 'pay'
    end
  end
end
