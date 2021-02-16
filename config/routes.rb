Rails.application.routes.draw do
  resources :exercises do
    get :setup, on: :member
  end
end
