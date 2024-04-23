Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :flights, only: [:index, :show] do
    member do
      delete '/destroy/:passenger_id', action: :destroy, as: 'destroy'
    end
  end
  resources :airlines, only: [:show]
end
