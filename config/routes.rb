
Rails.application.routes.draw do
  root 'home#index'
  
  resources :members, only: [:new, :create, :destroy, :update, :edit, :index] do
    resources :enrollments, only: [:create, :destroy], controller: 'enrollments'
    resource :participations, only: [:create, :destroy]
    get 'detail', on: :collection
  end
  resources :bsk_members, only: [:new, :create, :destroy, :update, :edit, :index] do
    resources :enrollments, only: [:create, :destroy], controller: 'enrollments'
    resource :bsk_participations, only: [:create, :destroy]
    get 'detail', on: :collection
  end
  
  resources :matches, only: [:new, :create, :show, :index, :destroy, :update]
  resources :bsk_matches, only: [:new, :create, :show, :index, :destroy, :update]
end

