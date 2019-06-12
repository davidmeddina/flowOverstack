# frozen_string_literal: true

Rails.application.routes.draw do
  root 'questions#index' # MODIFICAR
  devise_for :users

  resources :questions do
    resources :answers do
      resources :comments
    end
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
