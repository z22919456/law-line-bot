Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get '目錄', to: 'home#menu'

  # richmenu
  get '/dispatch/daily', to: 'dispatch#daily', as: :richmenu_daily
  get '/dispatch/registration', to: 'dispatch#user_registration', as: :richmenu_registration
  get '/dispatch/healthy_tracking', to: 'dispatch#user_menu', as: :richmenu_healthy_tracking
  get '/dispatch/menu', to: 'dispatch#user_menu', as: :richmenu_menu
  get '/dispatch/footprint', to: 'dispatch#user_menu', as: :richmenu_footprint

  # resource :user
  # resources :daily_reports
  # resources :org_daily_reports
  # resources :org_summeries

  resource :user, only: %i[show edit update] do
    resource :daily_report
    resources :org_daily_reports
    resource :org_summery
  end

  get '目前部門回報狀況', to: 'commands#daily_report_summery'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
