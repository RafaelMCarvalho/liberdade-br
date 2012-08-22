# -*- encoding : utf-8 -*-
require "spec_helper"

describe OpportunitiesController do
  it 'get opportunities page' do
    { :get => '/oportunidades' }.should route_to(:controller => 'opportunities', :action => 'index')
  end

  it 'get opportunity page' do
    { :get => '/oportunidade/1' }.should route_to(:controller => 'opportunities', :action => 'show', :id => '1')
  end
end

