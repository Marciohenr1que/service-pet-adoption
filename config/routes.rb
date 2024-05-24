Rails.application.routes.draw do
  root to: redirect('/swagger-ui/docs/index.html') 
  
  resources :pets, only: [:create, :update, :destroy, :index, :show] do
    get 'breed_info', on: :member
  end
  
  resources :owners, only: [:create, :update, :destroy, :index, :show]
end
