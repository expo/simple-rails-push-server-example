Rails.application.routes.draw do
  root 'tokens#index'
  resources :tokens, only: [:index, :create]
end
