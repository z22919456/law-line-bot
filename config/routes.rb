Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get '目錄', to: 'home#menu'
  resource :user
  resource :daily_reports
  resource :org_daily_reports

  get '目前部門回報狀況', to: 'commands#daily_report'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
