require 'sidekiq/web'

Rails.application.routes.draw do
  root to: redirect('/swagger-ui/docs/index.html') 
 

  resources :pets, only: [:create, :update, :destroy, :index, :show]
  resources :owners, only: [:create, :update, :destroy, :index, :show]

end
