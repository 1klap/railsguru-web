Rails.application.routes.draw do
  ### Domain ###
  resources :lessons
  resources :blogs, path: "blog", only: [ :index, :show ], param: :slug
  root "home#index"

  ### Auth ###
  resource :session, only: [ :new, :create, :destroy ]
  resources :passwords, param: :token, only: [ :new, :create, :edit, :update ]
  get "/auth/:provider/callback" => "sessions/omni_auths#create", as: :omniauth_callback
  post "/auth/:provider/callback" => "sessions/omni_auths#create"
  get "/auth/failure" => "sessions/omni_auths#failure", as: :omniauth_failure

  ### Operations ###
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
