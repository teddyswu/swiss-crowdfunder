Rails.application.routes.draw do

  get 'static/about-us', to: 'static#about_us'
  get 'static/terms-of-service', to: 'static#terms_of_service'
  get 'static/privacy-policy', to: 'static#privacy_policy'
  get 'static/exception_test', to: 'static#exception_test'

  devise_for :users#, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :campaign_qas
  resources :campaign_updates
  resources :campaign_replies

  resources :campaigns, only: [:show] do
    resources :goodies, only: [:index] do
      resources :orders, only: [:new, :show, :create]
    end
  end

  get '*any', via: :all, to: 'errors#not_found'

  root to: 'root#index'
end
