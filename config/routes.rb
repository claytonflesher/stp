Rails.application.routes.draw do

  resources :patient_messages
  get    "home"                            => "static_pages#home"
  get    "about"                           => "static_pages#about"
  get    "contact"                         => "static_pages#contact"
  get    "therapist_signup"                => "therapists#new",                  as: :therapist_signup
  post   "therapist_signup"                => "therapists#create"
  get    "therapist_signin"                => "therapists_sessions#new",         as: :therapist_signin
  post   "therapist_signin"                => "therapists_sessions#create"
  delete "therapist_signout"               => "therapists_sessions#destroy"
  get    "therapist_verify/:therapist_id"  => "therapists_verifications#new",    as: :therapist_verify
  get    "therapist_verify/confirm/:token" => "therapists_verifications#create", as: :therapist_confirm
  get    "therapist_dashboard"             => "therapists#show"
  get    "edit_therapist"                  => "therapists#edit"
  put    "update_therapist"                => "therapists#update"
  patch  "update_therapist"                => "therapists#update"
  get "therapist_profile/:therapist_id" => "therapists#profile"
  get "therapist_new_message/:patient_id" => "therapists#new_message"
  get "therapist_show_conversation/:patient_id" => "therapists#show_conversation"
  post "therapist_send_new_message" => "therapists#send_new_message"
  post "therapist_reply_to_message" => "therapists#reply_to_message"
  get "therapist_profile/:therapist_id" => "therapists#profile"
  get    "patient_signup"                  => "patients#new",                    as: :patient_signup
  post   "patient_signup"                  => "patients#create"
  get    "patient_signin"                  => "patients_sessions#new",           as: :patient_signin
  post   "patient_signin"                  => "patients_sessions#create"
  delete "patient_signout"                 => "patients_sessions#destroy"
  get    "patient_verify/:patient_id"      => "patients_verifications#new",      as: :patient_verify
  get    "patient_verify/confirm/:token"   => "patients_verifications#create",   as: :patient_confirm
  get    "patient_dashboard"               => "patients#show"
  get    "edit_patient"                    => "patients#edit"
  put    "update_patient"                  => "patients#update"
  patch  "update_patient"                  => "patients#update"
  get "patient_profile/:patient_id" => "patients#profile"
  get "patient_new_message/:therapist_id" => "patients#new_message"
  get "patient_show_conversation/:therapist_id" => "patients#show_conversation"
  post "patient_send_new_message" => "patients#send_new_message"
  post "patient_reply_to_message" => "patients#reply_to_message"
  get    "therapist_reset_password"             => "therapists_password_resets#new",   as: :therapist_reset_password
  post   "therapist_reset_password"             => "therapists_password_resets#create"
  get    "therapist_reset_password/:token/edit" => "therapists_password_resets#edit",  as: :edit_therapist_reset_password
  post   "therapist_reset_password/:token/edit" => "therapists_password_resets#update"
  get    "patient_reset_password"               => "patients_password_resets#new",     as: :patient_reset_password
  post   "patient_reset_password"               => "patients_password_resets#create"
  get    "patient_reset_password/:token/edit"   => "patients_password_resets#edit",    as: :edit_patient_reset_password
  post   "patient_reset_password/:token/edit"   => "patients_password_resets#update"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#home'

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
