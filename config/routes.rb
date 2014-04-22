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
  resources :sessions, only: [:new, :create, :destroy]
  
  resources :services do
    resources 'service_information'
  end
  
  resources :items do
    resources :item_versions do
      resources :item_fields do
        resources :item_field_posibilities
        resources :item_field_validations
      end
    end
  end
  
  resources :item_instances do
    resources :item_instance_values
  end
  
  resources :field_types do
    resources :field_validations
    resources :field_posibilities
    resources :field_map
  end
  


  match "/signup", to: "users#new", via: 'get', as: :signup
  match "/user/:id/activate", to: 'users#activate', via: 'patch', as: :activate_user
  
  match '/back', to: 'application#back', via: 'get', as: :back
  
  match '/signin',  to: 'sessions#new',         via: 'get', as: :signin
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/ajax_signout', to: 'sessions#ajax_destroy',     via: 'delete', as: :ajax_signout
  match '/reset', to: 'sessions#reset', via: 'get', as: :reset
  match '/send_reset', to: 'sessions#send_reset', via: 'post'
  
  match '/social_login', to: 'sessions#social_login', via: 'post', as: :social_login
  
  match '/profile', to: "users#profile", via: 'get', as: :profile
  match '/edit_password', to: 'users#edit_password', via: 'get', as: :edit_password
  match '/reset_password', to: 'users#reset', via: 'patch', as: :reset_password
  match '/password_recovery/:remember_token', to: 'users#password_recovery',
    via: 'get', as: :password_recovery
  match '/set_recovery_password', to: 'users#set_recovery_password',
    via: 'patch'
    
  match '/configuration', to: 'generals#show', via: 'get', as: :configuration
  
  match "/service/:id/activate", to: 'services#activate', via: 'patch', as: :activate_service
  
  match "/item/:id/activate", to: 'items#activate', via: 'patch', as: :activate_item
  
  match '/item/:item_id/version/:id/close', to: "item_versions#close",via: 'patch', as: :close_item_item_version
  
  match "/item/:item_id/item_version/:item_version_id/item_field/:id/activate", to: 'item_fields#activate', via: 'patch', as: :activate_item_item_version_item_field
  
  match "/field_type/:id/activate", to: 'field_types#activate', via: 'patch', as: :activate_field_type
  match "/field_type/:field_type_id/field_posibility/:id/activate", to: 'field_posibilities#activate', via: 'patch', as: :activate_field_type_field_posibility
  match "/field_type/:field_type_id/field_map/:id/activate", to: 'field_map#activate', via: 'patch', as: :activate_field_type_field_map
  
  #PRODUCTS
  match "/products/:item", to: 'item_instances#index', via: 'get', as: :products
  match "products/:item/new", to: 'item_instances#new', via: 'get', as: :new_product
  match "products/:item/", to: 'item_instances#create', via: 'post', as: :create_product
  match "products/:item/:id", to: 'item_instances#show', via: 'get', as: :show_product
  match "products/:item/:id/edit", to: 'item_instances#edit', via: 'get', as: :edit_product
  match "products/:item/:id", to: 'item_instances#update', via: 'patch', as: :update_product
  match "products/:item/:id", to: 'item_instances#destroy', via: 'delete', as: :destroy_product
  match "products/:item/:id/activate", to: 'item_instances#activate', via: 'patch', as: :activate_product
  match "products", to: "item_instances#multi_index", via: 'get', as: :multi_products
  #FALLBACK ROUTER - STATIC PAGES
  get ":page_name" => "pages#show", as: :static_page
end
