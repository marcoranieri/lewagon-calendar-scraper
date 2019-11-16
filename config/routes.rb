Rails.application.routes.draw do
  get 'days/index'
  get 'days/show'
  get 'batches/index'
  get 'batches/show'
  devise_for :users

  resources :batches, only: [:index, :show] do
    resources :days, only: [:index, :show]
  end

  root to: 'batches#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
