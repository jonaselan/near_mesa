Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: :sessions },
                     path_names: {
                       sign_in: :login
                     }
  namespace :api do
    namespace :v1 do
      resources :comments
      resources :locations
      resources :users
    end
  end
end
