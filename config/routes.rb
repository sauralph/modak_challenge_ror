Rails.application.routes.draw do
  post 'notifications', to: 'notifications#create'

  resources :notification_rate_limits
end
