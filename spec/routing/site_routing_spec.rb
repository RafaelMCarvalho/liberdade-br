# -*- encoding : utf-8 -*-
require "spec_helper"

describe SiteController do
  it 'index page' do
    { :get => '/' }.should route_to(:controller => 'site', :action => 'index')
  end

  it 'contact page' do
    { :get => '/contact' }.should route_to(:controller => 'site', :action => 'contact')
  end

  it 'posts page' do
    { :get => '/posts' }.should route_to(:controller => 'site', :action => 'posts')
  end

  it 'post page' do
    { :get => '/post/1' }.should route_to(:controller => 'site', :action => 'post', :id => '1')
  end

  it 'send contact message action' do
    { :post => '/contact' }.should route_to(:controller => 'site', :action => 'send_contact')
  end
end

