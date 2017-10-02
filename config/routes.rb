Rails.application.routes.draw do
  resources :accounts, only: [:show]
  resources :authentications, only: [:create, :new]
end
