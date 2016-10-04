Rails.application.routes.draw do
  # get 'welcome/home'  #this was here for PairBnb
  
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]                                           
  resource :session, controller: "clearance/sessions", only: [:create]
                                                        #the route action is only available for #create
                                                        #doc 4.6 restring routes created. 
  resources :users, controller: "users", only: [:create] do  #fixed done                               
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :users, only: [:show, :edit, :update, :destroy]  
    
  # Oct 2- possible to nest with users, but for now, the idea seems weird and complicated 
  resources :courses

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  #this is similar as writing: 
    #get 'profile', to: 'users#show'
    #get 'profile', to: :show, controller: 'users'

  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
                    #^, to:                           #^will generate named helpers called: sign_out_path , sign_out_url
  get "/sign_up" => "clearance/users#new", as: "sign_up"
    #  ^ url path                ^controller_name#method defined inside the controller

    #position root was originally here.
    
  #Sept 16 to enable omniauthfb
    #this step is necessary to ensure that the controller knows where to pinpoint once login successful
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  # #sept17 exp:
  # get "/auth/failure" => "sessions#failure"

  

  root 'welcome#home'
        #^view_folder#file_name
        #unless override, upon sign in, Rails will direct to home page by default for the '/' path



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
