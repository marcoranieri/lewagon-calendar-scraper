Rails.application.routes.draw do
  devise_for :users

  resources :batches, only: [:index, :show, :create] do
    resources :days, only: [:index, :show]
  end

  get 'batches/:id/teacher', to: "batches#teacher", as: "teacher"
  get 'batches/:id/assistant', to: "batches#assistant", as: "assistant"

  root to: 'batches#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
