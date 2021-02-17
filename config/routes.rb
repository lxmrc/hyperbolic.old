Rails.application.routes.draw do
  resources :exercises do
    get :setup, on: :member
    get :attempt, on: :member
  end
end
