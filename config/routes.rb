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
  
  # You can have the root of your site routed with "root"
  root 'pages#home'

  #RESOURCES
  resource :administrators, only: [:index, :new, :create]
  resources :users
  resource 'generals'
  resources :sessions, only: [:new, :create, :destroy]
 
  match "/signup", to: "users#new", via: 'get', as: :signup
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  
  #FALLBACK ROUTER - STATIC PAGES
  get ":page_name" => "pages#show", as: :static_page
end
