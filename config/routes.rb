Rails.application.routes.draw do
  get 'users/create'
  get 'sessions/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :sessions, only: %i[create]
      resources :users, only: %i[create]
      resources :todos, only: %i[index]
    end
  end
end
