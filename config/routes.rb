Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :staffs
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get '/logout' => "devise/sessions#destroy"
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'products#index'

  post 'new_order' => 'orders#batch_create'
  post 'update_orders' => 'orders#update_orders'
  get 'my_orders' => 'orders#my_orders'
  get 'order_notice' => 'pages#order_notice'

  get 'staff' => 'staff#index'
  scope 'staff' do
    get 'show_user_data' => 'staff#show_user_data'
    get 'confirm_payment' => 'staff#confirm_payment'
    post 'confirm_payment' => 'staff#confirm_payment_update'
    get 'receive_payment' => 'staff#receive_payment'
    get 'receive_payment/show' => 'staff#receive_payment_show'
    post 'receive_payment' => 'staff#receive_payment_update'
    get 'deliver' => 'staff#deliver'
    get 'deliver/show' => 'staff#deliver_show'
    post 'deliver' => 'staff#deliver_update'
    get 'issue' => 'staff#issue'
    get 'issue/show' => 'staff#issue_show'
    post 'issue' => 'staff#issue_update'
    post 'rollback' => 'staff#rollback'
  end

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
