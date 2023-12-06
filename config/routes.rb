Rails.application.routes.draw do
  resources :suggested_translations
  resources :attachments
  namespace :admin do
    resources :posts do
      resources :comments, except: :show
    end

    resources :comments
    resources :subscriptions
  end

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
