Offtrafik::Application.routes.draw do
  
  devise_for :users, controllers: { registrations: 'users' }
  
  devise_scope :user do
    get 'users/:id/postings' => 'users#postings', as: :user_postings
    get 'users/:id/past_postings' => 'users#past_postings', as: :user_past_postings
    match 'users/:id' => 'users#show', as: :user
    match 'users/:id/edit' => 'users#edit', as: :edit_user
  end
  
  root to: 'static_pages#home'
  
  # Matching static_pages
  match '/', to: 'static_pages#home'
  match '/help', to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/why', to: 'static_pages#why'
  match '/terms_and_conditions', to: 'static_pages#terms_and_conditions'
  match '/admin', to: 'static_pages#admin'
  
  # Matching postings
  match '/find_posting', to: 'postings#find'
  match '/find_from_home', to: 'postings#find_from_home_page'
  match '/find_user', to: 'users#find'
  match '/share_posting', to: 'postings#share_posting'
  match '/all_postings', to: 'postings#all_postings'

  resources :postings do
    post 'respond', as: :respond
    get 'contact_posting_owner'
    get 'full', as: :full
  end
  
  resources :frequent_postings
  resources :comments


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
