Rails.application.routes.draw do
  resources :exercises do
    post :start_container, on: :member
    post :update_container, on: :member
    resources :iterations do
    end

  end

  post '/exercises/:exercise_id/iterations/:token/run_tests', to: 'iterations#run_tests', as: :run_tests
  post '/exercises/:exercise_id/iterations/:token/start_container', to: 'iterations#start_container', as: :start_container
  post '/exercises/:exercise_id/iterations/:token/stop_container', to: 'iterations#stop_container', as: :stop_container
end
