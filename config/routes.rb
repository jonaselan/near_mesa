Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: :sessions },
                     path_names: {
                       sign_in: :login
                     }
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :locations, only: :create
      end

      resources :locations, only: :index do
        resources :ratings, only: %i[index create]
        resources :comments, only: %i[index create]
      end
    end
  end
end
