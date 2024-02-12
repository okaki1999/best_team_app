
Rails.application.routes.draw do
  root 'home#index'
  
  resources :members, only: [:new, :create, :destroy, :update, :edit, :show] do
    resources :enrollments, only: [:create, :destroy], controller: 'enrollments'
    resource :participations, only: [:create, :destroy]
  end
  
  resources :matches, only: [:new, :create, :show, :index, :destroy, :update]
end

