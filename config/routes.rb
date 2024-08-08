Rails.application.routes.draw do
  post 'notifications', to: 'notifications#create'

  resources :notifications
  resources :notification_rate_limits
  
end
