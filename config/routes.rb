# -*- encoding : utf-8 -*-

LiberdadeBr::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

#= 1. user routes ==============================================================
  devise_for :users

#= 2. pages ====================================================================
  get "/contact" => "site#contact", :as => :contact
  post "/contact" => "site#send_contact", :as => :send_contact
  get '/about' => 'site#about', :as => :about
  get '/faq' => 'site#faq', :as => :faq
  get '/financers' => 'site#financers', :as => :financers

#= 3. Post evaluation routes ===================================================
  post "/admin/post/:post_id/approve/:user_id" => "posts#approve", :as => :approve_post
  post "/admin/post/:post_id/reprove/:user_id" => "posts#reprove", :as => :reprove_post

#= 4. Author ===================================================================
  get '/posts/author/:id' => 'posts#per_author', :as => :posts_author

#= 5. Blog =====================================================================
  get '/posts/blog/:id' => 'posts#per_blog', :as => :posts_blog

#= 6. Category =================================================================
  get '/posts/category/:id' => 'posts#per_category', :as => :posts_category

#= 7. Post =====================================================================
  resources :posts, :only => [:index, :show, :new]
  post "/posts" => "posts#index", :as => :posts
  post '/posts/send' => 'posts#send_post', :as => :send_post

#= 8. Events and Opportunities =================================================
  get '/eventos-e-oportunidades' => 'site#events_and_opportunities', :as => :events_and_opportunities

#= 9. Events ===================================================================
  get '/eventos' => 'events#index', :as => :events
  get '/evento/:id' => 'events#show', :as => :event

#= 10. Opportunities ===========================================================
  get '/oportunidades' => 'opportunities#index', :as => :opportunities
  get '/oportunidade/:id' => 'opportunities#show', :as => :opportunity

  root :to => "site#index"
end
