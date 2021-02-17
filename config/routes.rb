Rails.application.routes.draw do
  resources :exercises do
    resources :iterations
  end
end
