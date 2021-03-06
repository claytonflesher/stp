Rails.application.routes.draw do

  get    "/.well-known/acme-challenge/:id" => "static_pages#letsencrypt"
  get    "home"                            => "static_pages#home"
  get    "about"                           => "static_pages#about"
  get    "contact"                         => "static_pages#contact"

  get    "therapist_signup"                => "therapists#new",                  as: :therapist_signup
  post   "therapist_signup"                => "therapists#create"
  delete "therapist_delete"                => "therapists#delete"
  get    "therapist_signin"                => "therapists_sessions#new",         as: :therapist_signin
  post   "therapist_signin"                => "therapists_sessions#create"
  delete "therapist_signout"               => "therapists_sessions#destroy"
  get    "therapist_verify/:therapist_id"  => "therapists_verifications#new",    as: :therapist_verify
  post   "therapist_verify/confirm/:token" => "therapists_verifications#create", as: :therapist_confirm
  post   "therapist_verify/deny/:token"    => "therapists_verifications#delete", as: :therapist_deny
  get    "therapist_dashboard/:therapist_id"             => "therapists#show",   as: :therapist_dashboard
  get    "edit_therapist"                  => "therapists#edit"
  put    "update_therapist"                => "therapists#update"
  patch  "update_therapist"                => "therapists#update"

  get    "therapist_info/:therapist_id"    => "votes#show",                      as: :therapist_info
  get    "votes"                           => "votes#index"
  post   "votes"                           => "votes#create"
  post   "change_vote"                     => "votes#delete",                    as: :change_vote
  get    "therapist_profile/:therapist_id" => "therapists#profile"
  get    "therapist_reset_password"             => "therapists_password_resets#new",   as: :therapist_reset_password
  post   "therapist_reset_password"             => "therapists_password_resets#create"
  get    "therapist_reset_password/:token/edit" => "therapists_password_resets#edit",  as: :edit_therapist_reset_password
  post   "therapist_reset_password/:token/edit" => "therapists_password_resets#update"

  get    "patient_signup"                  => "patients#new",                    as: :patient_signup
  post   "patient_signup"                  => "patients#create"
  delete "patient_delete"                  => "patients#destroy",                as: :patient_delete
  get    "patient_signin"                  => "patients_sessions#new",           as: :patient_signin
  post   "patient_signin"                  => "patients_sessions#create"
  delete "patient_signout"                 => "patients_sessions#destroy"
  get    "patient_verify/:patient_id"      => "patients_verifications#new",      as: :patient_verify
  get    "patient_verify/confirm/:token"   => "patients_verifications#create",   as: :patient_confirm
  get    "patient_dashboard/:patient_id"   => "patients#show",                   as: :patient_dashboard
  get    "edit_patient"                    => "patients#edit"
  put    "update_patient"                  => "patients#update"
  patch  "update_patient"                  => "patients#update"
  get    "patient_profile/:patient_id"     => "patients#profile"
  get    "patient_reset_password"               => "patients_password_resets#new",     as: :patient_reset_password
  post   "patient_reset_password"               => "patients_password_resets#create"
  get    "patient_reset_password/:token/edit"   => "patients_password_resets#edit",    as: :edit_patient_reset_password
  post   "patient_reset_password/:token/edit"   => "patients_password_resets#update"
  get    "admins"                               => "admins#index"
  get    "admins/:therapist_id"                 => "admins#show",       as: :admin_show
  get    "super_admins"                         => "super_admins#index"
  get    "super_admins/:therapist_id"           => "super_admins#show", as: :super_admin_show
  post   "super_admins/:therapist_id"           => "super_admins#update"
  post   "patient_therapist_relationships/admin_message"                 => "patient_therapist_relationships#admin_message"

  post "new_connection_request"    => "patient_therapist_relationships#create", as: :new_connection_request
  post "update_connection_request" => "patient_therapist_relationships#update", as: :update_connection_request

  get "exceeded_requests" => "patient_therapist_relationships#exceeded_requests", as: :exceeded_requests

  get "inbox" => "messages#index", as: :inbox
  post "messages" => "messages#create"
  post "opened" => "messages#update", as: :opened

  get "conversations"                                   => "conversations#index"
  get "conversations/:conversation_id"                  => "conversations#show",  as: :conversation
  get "conversation/:patient_therapist_relationship_id" => "conversations#create", as: :create_conversation

  get  "therapist_searches" => "therapist_searches#show"
  post "therapist_searches" => "therapist_searches#update"
  
  get  "therapist_details"  => "therapist_details#show"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#home'
end
