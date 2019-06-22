# frozen_string_literal: true

Rails.application.routes.draw do
  root 'questions#index' # MODIFICAR
  devise_for :users, controllers: {omniauth_callbacks: 'callbacks'}

  resources :questions do
    resource :vote
    resources :answers
    resources :comments
  end

  resources :answers do
    resource :vote
    resources :comments
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
