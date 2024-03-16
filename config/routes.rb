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
    resources :posts do
      resources :comments do
        resources :replies, only: [:create]
      end
    end
    resources :attachments, except: [:index, :show]
    resources :suggested_translations
    resources :comments
    resources :subscriptions
  end

  resources :profiles, only: [:show, :edit, :update]

  # resources :posts do
  #   resources :comments, except: :show
  # end

  devise_for :users

  resources :subscriptions, only: [:create, :show]

  # resources :subscriptions, only: [:create, :show]

  get 'welcome/index'
  get 'welcome/about'
  get 'support/index'
  get 'change_locale', to: 'welcome#change_locale', as: 'change_locale'
  post 'support/request_support'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"
end
