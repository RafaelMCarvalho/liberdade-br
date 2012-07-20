# -*- encoding : utf-8 -*-

LiberdadeBr::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

#= 1. user routes ==============================================================
  devise_for :users

#= 2. contact routes ===========================================================
  get "/contact" => "site#contact", :as => :contact
  post "/contact" => "site#send_contact", :as => :send_contact

#= 3. Post evaluation routes ===================================================
  match "/admin/post/:post_id/accept/:user_id" => "post#accept", :as => :accept_post
  match "/admin/post/:post_id/reject/:user_id" => "post#reject", :as => :reject_post

  root :to => "site#index"
end

