Newspaper::Application.routes.draw do
  root :to => "homes#show"
  devise_for :users, :controllers => {:sessions => "users/sessions", :passwords => "passwords" }
  resources :passwords

  resources :stories
  # resources :users
  resources :profiles

  match 'dashboard/admin' => 'dashboard#admin', :as => :admin_dashboard
  match 'dashboard/writer' => "dashboard#writer" , :as => :writer_dashboard
  match 'dashboard/editor' => "dashboard#editor" , :as => :editor_dashboard
  match 'story/:id' => "stories#show_public" , :as => :story_public
  
  
  match 'wait_for_confirmation' => "homes#wait_for_confirmation" , :as => :confirmation_waiting

  match 'admin/join_request' => "admin#show_non_approved_requests" , :as => :nonapproved_request 
  match 'user/crop_profile_pic' => "profiles#show_cropper", :as => :cropper
  match 'user/execute_crop_profile_pic' => "profiles#crop", :as => :crop_profile_image

  match 'writer/:id' => "profiles#show", :as => :vanity



  match 'profile/edit_credential' => "profiles#edit_credential", :as => :edit_credential
  match 'profile/update_credential' => "profiles#update_credential", :as => :update_credential
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
