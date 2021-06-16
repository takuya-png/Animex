Rails.application.routes.draw do
  resources :topics do
    resources :comments
  end
  post '/topics/guest_sign_in', to: 'topics#guest_sign_in'
  resources :topics
  resources :favorites, only: [:create, :destroy]
  root 'topics#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
end
