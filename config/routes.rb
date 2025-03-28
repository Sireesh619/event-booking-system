Rails.application.routes.draw do
  get 'home/index'
  namespace :api do
    namespace :v1 do
      resources :events, only: [:index, :new, :edit, :destroy, :show, :create, :update]
      get 'events/:id', to: 'events#show', as: 'show_event'
      delete 'events/:id', to: 'events#destroy', as: 'delete_event'
      resources :bookings, only: [:new, :update, :destroy, :index, :show, :create]
    end
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root 'home#index'
end