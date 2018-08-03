Rails.application.routes.draw do

  resources :loans, only: [:index, :show, :update], defaults: {format: :json} do
    resources :payments, only: [:create], defaults: {format: :json}
  end

end
