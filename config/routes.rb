Rails.application.routes.draw do
  get 'home/index'
  root "home#index" # or another controller#action you want as the homepage
  resources :notifications
  resources :notification_rate_limits
  
end
