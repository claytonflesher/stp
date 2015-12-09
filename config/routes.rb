Rails.application.routes.draw do

  get    "landing_page"                    => "landing_page#index"
  get    "therapist_signup"                => "therapists#new",                  as: :therapist_signup
  post   "therapist_signup"                => "therapists#create"
  get    "therapist_signin"                => "therapists_sessions#new",         as: :therapist_signin
  post   "therapist_signin"                => "therapists_sessions#create"
  delete "therapist_signout"               => "therapists_sessions#destroy"
  get    "therapist_verify/:therapist_id"  => "therapists_verifications#new",    as: :therapist_verify
  get    "therapist_verify/confirm/:token" => "therapists_verifications#create", as: :therapist_confirm
  get    "signup"                          => "patients#new",                    as: :signup
  post   "signup"                          => "patients#create"
  get    "signin"                          => "patients_sessions#new",           as: :signin
  post   "signin"                          => "patients_sessions#create"
  delete "signout"                         => "patients_sessions#destroy"
  get    "verify/:patient_id"              => "patients_verifications#new",      as: :patient_verify
  get    "verify/confirm/:token"           => "patients_verifications#create",   as: :patient_confirm
  get    "patient_dashboard"               => "patients#show"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'landing_page#index'

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
