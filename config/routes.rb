Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show, :index, :edit, :update] , path_names: { new: 'sign_up' }
  resource :session, only: [:new, :create, :destroy], path: 'session', path_names: { new: 'new' }
  resources :passwords, param: :token
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy]
  root to: "homes#top"
  get 'home/about' => 'homes#about', as: 'home_about'
  get "up" => "rails/health#show", as: :rails_health_check
end
