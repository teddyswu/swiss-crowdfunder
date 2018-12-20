Rails.application.routes.draw do

  get 'static/about-us', to: 'static#about_us'
  get 'static/terms-of-service', to: 'static#terms_of_service'
  get 'static/privacy-policy', to: 'static#privacy_policy'
  get 'static/exception_test', to: 'static#exception_test'

  #devise_for :users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => { :registrations => "user/registrations",:omniauth_callbacks => "user/omniauth_callbacks" }
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
    resources :goodies, only: [:index] do
      resources :orders, only: [:new, :show, :create]
    end

  end
  resources :campaign_tags

  resources :orders, only: [:index] do
    get "finished", :on => :member
    get "go_pay", :on => :member
    post "is_paid", :on => :member
    post "add_evaluation", :on => :member
    get "detail",:on => :member
  end

  get '*any', via: :all, to: 'errors#not_found'

  root to: 'root#index'
end
