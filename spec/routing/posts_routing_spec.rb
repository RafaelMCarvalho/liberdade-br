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
end

