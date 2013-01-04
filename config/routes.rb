Server::Application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
  end

  get "home/index"

  resources :tags

  # API routes
  namespace :api do
    resources :auth, :only => [:create]
    post "auth/destroy", :to => "auth#destroy"

    resources :tags, :only => [:show, :index]
    post "tags/delete", :to => "tags#destroy"
    post "tags/create", :to => "tags#create"
    post "tags/update", :to => "tags#update"

    post "register",   :to => "devices#register"
    post "unregister", :to => "devices#unregister"

    # api/users

    resources :messages, :only => [:show, :index]
    post "send", :to => "messages#send"
    post "messages/delete", :to => "messages#delete"
  end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  root :to => 'home#index'
end
