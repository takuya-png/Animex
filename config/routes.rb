Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/guest_admin_sign_in', to: 'users/sessions#guest_admin_sign_in'
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  post '/topics/guest_sign_in', to: 'topics#guest_sign_in'
  
  root 'tops#index'

  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy, :index]
  resources :users do
    member do
      get :following, :followers
    end
  end  

  resources :topics do
    resources :comments
      collection do
        get 'search'
      end
  end
end
