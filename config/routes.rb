Shopcart::Application.routes.draw do
  #AJAX VALIDATIONS
  post "validator/new"
  
  #ERRORS
  get "/404", :to => "errors#not_found"
  get "/422", :to => "errors#unacceptable"
  get "/500", :to => "errors#internal_error"
  
  #installation routes
  get "/installation", to: "generals#index", as: :start_installation
  get "installation/user/new", to:"administrators#new", as: :installation_step_one
  get "installation/configuration/new", to: "generals#new", as: :installation_step_two

  #Orden compra
  get 'orden_compra'      , to: 'orden_compra#index', as: :orden_compra_root
  get 'orden_compra/index', to: 'orden_compra#index', as: :orden_compra_index
  get 'orden_compra/new'  , to: 'orden_compra#new'  , as: :orden_compra_new
  post 'orden_compra/paypal_notification/:id', to: 'orden_compra#paypal_notification', as: :paypal_notification

  # You can have the root of your site routed with "root"
  root 'pages#home'

  #RESOURCES
  resources :administrators, only: [:index, :new, :create]
  resources :users
  resources :generals
  resources :services
  resources :sessions, only: [:new, :create, :destroy]

  match "/signup", to: "users#new", via: 'get', as: :signup
  match "/user/:id/activate", to: 'users#activate', via: 'patch', as: :activate_user
  
  match '/signin',  to: 'sessions#new',         via: 'get', as: :signin
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/reset', to: 'sessions#reset', via: 'get', as: :reset
  match '/send_reset', to: 'sessions#send_reset', via: 'post'
  

  match '/profile', to: "users#profile", via: 'get', as: :profile
  match '/edit_password', to: 'users#edit_password', via: 'get', as: :edit_password
  match '/reset_password', to: 'users#reset', via: 'patch', as: :reset_password
  match '/password_recovery/:remember_token', to: 'users#password_recovery',
    via: 'get', as: :password_recovery
  match '/set_recovery_password', to: 'users#set_recovery_password',
    via: 'patch'
    
  match '/configuration', to: 'generals#show', via: 'get', as: :configuration
  
  match "/service/:id/activate", to: 'services#activate', via: 'patch', as: :activate_service
  
  #FALLBACK ROUTER - STATIC PAGES
  get ":page_name" => "pages#show", as: :static_page
end
