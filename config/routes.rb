# -*- encoding : utf-8 -*-

LiberdadeBr::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

#= 1. user routes ==============================================================
  devise_for :users

#= 2. posts routes =============================================================
  get '/posts/:id' => 'site#post', :as => :post

#= 3. contact routes ===========================================================
  get "/contact" => "site#contact", :as => :contact
  post "/contact" => "site#send_contact", :as => :send_contact

#= 4. Post evaluation routes ===================================================
  match "/admin/post/:post_id/approve/:user_id" => "post#approve", :as => :approve_post
  match "/admin/post/:post_id/reprove/:user_id" => "post#reprove", :as => :reprove_post

  root :to => "site#index"
end
