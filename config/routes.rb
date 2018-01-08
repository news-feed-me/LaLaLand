Rails.application.routes.draw do
  # API_Key
  # 43a167ad5e5943c386c72685062b81c8
  # f52e670563fe4fe5b0d06da57eb0bbf6
  root 'access#login'
  get 'access/login'

  get 'users/new'

  get "users/new", to: "users#new", as: :signup
  post "users/create", to: "users#create", as: :create
  get "access/login", to: "access#login", as: :login
  post 'access/attempt_login', to:"access#attempt_login", as: :attempt_login
  get "welcome/index", to: "welcome#index", as: :home
  get "access/logout", to: "access#logout", as: :logout
  get 'access/index', to: "access#index", as: :access_index
  get 'users/user_profile', to: "users#user_profile", as: :user_profile
  get 'users/edit_subscriptions', to: "users#edit_subscriptions"
  get 'users/favourites', to: "users#favourites"
  #get 'users/update_subscribes', to: "users#update_subscribes", as: :update_subscribes
  resources :widgets
  resources :users
  resources :subscribes
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


  # Default route
  match ':controller(/:action(/:id(.:format)))', :via => [:get, :post]

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
