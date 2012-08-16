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
  post "/admin/post/:post_id/approve/:user_id" => "posts#approve", :as => :approve_post
  post "/admin/post/:post_id/reprove/:user_id" => "posts#reprove", :as => :reprove_post

#= 4. Author ===================================================================
  get '/posts/author/:id' => 'posts#per_author', :as => :posts_author

#= 5. Blog =====================================================================
  get '/posts/blog/:id' => 'posts#per_blog', :as => :posts_blog

#= 6. Post =====================================================================
  resources :posts, :only => [:index, :show]
  post "/posts" => "posts#index", :as => :posts

#= 7. Events and Opportunities =================================================
  get '/eventos-e-oportunidades' => 'site#events_and_opportunities', :as => :events_and_opportunities

  root :to => "site#index"
end
