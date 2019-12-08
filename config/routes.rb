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
      resources :users
      resources :locations, only: %i[index create] do
        resources :reviews, only: %i[index create]
      end
    end
  end
end
