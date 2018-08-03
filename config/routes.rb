Rails.application.routes.draw do
  get 'payments/create'

  resources :loans, defaults: {format: :json}
end
