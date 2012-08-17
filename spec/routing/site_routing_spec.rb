# -*- encoding : utf-8 -*-
require "spec_helper"

describe SiteController do
  it 'index page' do
    { :get => '/' }.should route_to(:controller => 'site', :action => 'index')
  end

  it 'contact page' do
    { :get => '/contact' }.should route_to(:controller => 'site', :action => 'contact')
  end

  it 'about page' do
    { :get => '/about' }.should route_to(:controller => 'site', :action => 'about')
  end

  it 'faq page' do
    { :get => '/faq' }.should route_to(:controller => 'site', :action => 'faq')
  end

  it 'posts page' do
    { :get => '/posts' }.should route_to(:controller => 'posts', :action => 'index')
  end

  it 'post page' do
    { :get => '/posts/1' }.should route_to(:controller => 'posts', :action => 'show', :id => '1')
  end

  it 'send contact message action' do
    { :post => '/contact' }.should route_to(:controller => 'site', :action => 'send_contact')
  end
end

