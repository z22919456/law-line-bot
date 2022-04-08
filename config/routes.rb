Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get '目錄', to: 'home#menu'
  resource :user
  resource :daily_reports
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
