Rails.application.routes.draw do

  devise_for :users

  resources :products do
    resources :prices
    member do
      get 'toggle_visible'
      get 'make_featured'
    end
    
    collection do
      get 'display_order'
      post 'update_display_order'
    end
  end

  resources :dashboard do
    collection do
      get 'games'
      get 'beers'
      get 'pizzas'
    end
  end
  resources :games do
    member do
      get 'toggle_visible'
      get 'make_featured'
      get 'set_high_scores'
      patch 'update_scores'
    end
    collection do
      get 'display_order'
      post 'update_display_order'
    end
    
  end
  
  resources :beers do
    member do
      get 'toggle_visible'
      get 'make_featured'
    end
    collection do
      get 'display_order'
      post 'update_display_order'
    end
  end

  resources :pizzas do
    member do
      get 'toggle_visible'
      get 'make_featured'
    end
    collection do
      get 'display_order'
      post 'update_display_order'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => 'main#index'

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
