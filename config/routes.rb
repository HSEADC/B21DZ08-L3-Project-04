Rails.application.routes.draw do

  namespace :admin do
    resources :posts do
      resources :comments, except: :show
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
  get 'change_locale', to: 'welcome#change_locale', as: 'change_locale'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"
end
