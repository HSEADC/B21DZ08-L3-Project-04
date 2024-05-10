Rails.application.routes.draw do
  get 'replies/new'
  get 'replies/create'

  namespace :api do
    namespace :v1 do
      resources :posts

      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        post "sign_out", to: "sessions#destroy"
      end
    end
  end

  namespace :admin do
    resources :subscriptions
  end

  resources :posts do
    member do
      get 'toggle_favourite', to: 'posts#toggle_favourite', as: 'toggle_favourite'
      get 'toggle_like', to: 'posts#toggle_like', as: 'toggle_like'
    end

    resources :comments
  end

  resources :comments
  resources :profiles, only: [:show, :edit, :update]

  devise_for :users

  resources :subscriptions, only: [:create, :show]

  get 'welcome/index'
  get 'welcome/about'
  get 'support/index'
  get 'change_locale', to: 'welcome#change_locale', as: 'change_locale'
  post 'support/request_support'
  # спросить у захара почему ничего не работает если сделать post
  get '/follows', to: 'follows#create'
  
  get 'welcome/search'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"
end
