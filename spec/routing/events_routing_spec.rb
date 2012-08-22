# -*- encoding : utf-8 -*-
require "spec_helper"

describe EventsController do
  it 'get events page' do
    { :get => '/eventos' }.should route_to(:controller => 'events', :action => 'index')
  end

  it 'get event page' do
    { :get => '/evento/1' }.should route_to(:controller => 'events', :action => 'show', :id => '1')
  end
end

