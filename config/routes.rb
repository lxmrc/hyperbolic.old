Rails.application.routes.draw do
  resources :exercises do
    post :start_container, on: :member
    post :update_container, on: :member
    resources :iterations 
  end
end
