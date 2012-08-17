# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'about page' do
  background do
    FactoryGirl.create :configuration
    @about_page = FactoryGirl.create :page, :indicator => Page::PAGES[:about], 
                              :content => 'Página sobre o Liberdade.br'
  end

  scenario 'should show when is published' do
    visit '/'
    click_link 'Sobre o Liberdade.br'
    page.should have_content 'Página sobre o Liberdade.br'
    current_path.should == about_path
  end

  context 'should not show when is not published' do
    background { @about_page.update_attribute(:published, false) }

    scenario 'through index page' do
      visit '/'
      lambda { click_link 'Sobre o Liberdade.br' }.should raise_error(Capybara::ElementNotFound)
    end

    scenario 'visiting about route' do
      lambda { visit about_path }.should raise_error(ActionController::RoutingError)
    end
  end
end