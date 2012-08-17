# -*- encoding : utf-8 -*-
require "spec_helper"

describe PostsController do
  it 'get posts page' do
    { :get => '/posts' }.should route_to(:controller => 'posts', :action => 'index')
  end

  it 'get post page' do
    { :get => '/posts/1' }.should route_to(:controller => 'posts', :action => 'show', :id => '1')
  end

  it 'post to posts page' do
    { :post => '/posts' }.should route_to(:controller => 'posts', :action => 'index')
  end

  it 'get to posts by author page' do
    { :get => '/posts/author/1' }.should route_to(:controller => 'posts', :action => 'per_author', :id => '1')
  end

  it 'get to posts by blog page' do
    { :get => '/posts/blog/1' }.should route_to(:controller => 'posts', :action => 'per_blog', :id => '1')
  end

  it 'get send post page' do
    { :get => '/posts/new' }.should route_to(:controller => 'posts', :action => 'new')
  end

  it 'post to send post page' do
    { :post => '/posts/send' }.should route_to(:controller => 'posts', :action => 'send_post')
  end
end

