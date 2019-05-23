Rails.application.routes.draw do

  get 'about', to: 'static#about_us'
  get 'terms', to: 'static#terms_of_service'
  get 'privacy', to: 'static#privacy_policy'
  get 'static/exception_test', to: 'static#exception_test'
  get 'contract', to: 'static#contract'

  #devise_for :users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => { :registrations => "user/registrations",:omniauth_callbacks => "user/omniauth_callbacks", :sessions => "user/sessions" }
  ActiveAdmin.routes(self)
  resources :users
  resources :campaign_qas
  get "campaigns/:id/qas", :to => "campaign_qas#show", :as => "campaign_show_qa"
  resources :campaign_updates
  get "campaigns/:id/updates", :to => "campaign_updates#show", :as => "campaign_show_update"
  get "campaigns/:id/updates/:update_id", :to => "campaign_updates#detail", :as => "campaign_update_detail"
  resources :campaign_replies
  get "campaigns/:id/replies", :to => "campaign_replies#show", :as => "campaign_show_reply"
  resources :tracks do 
    get "cancel", :on => :collection
  end

  resources :favo_farmers

  resources :campaigns do
    get "list", :on => :member
    get "group", :on => :member
    get "support", :on => :member
    get "group_edit", :on => :member
    post "group_create",:on => :collection
    delete "gruop_del", :on => :member
    get "goody", :on => :member
    get "goody_edit", :on => :member
    patch "goody_update", :on => :member
    post "goody_create",:on => :collection
    delete "goody_del", :on => :member
    get "check_slug", :on => :collection
    get "rate", :on => :member
    resources :goodies, only: [:index] do
      resources :orders, only: [:new, :show, :create]
    end

  end
  resources :campaign_tags

  resources :orders, only: [:index, :edit, :update] do
    match "finished", :on => :member, via: [:get, :post]
    get "go_pay", :on => :member
    post "is_paid", :on => :member
    post "payment_info", :on => :member
    post "add_evaluation", :on => :member
    get "detail",:on => :member
    get "user_info", :on => :collection
  end

  get '*any', via: :all, to: 'errors#not_found'

  root to: 'root#index'
end
