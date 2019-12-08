Rails.application.routes.draw do
  devise_for :users,
  path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'register'
  },
   controllers: {
    registrations: 'api/v1/registrations',
    sessions: 'api/v1/sessions'
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
