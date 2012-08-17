# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'faq page' do
  background do
    FactoryGirl.create :configuration
    @faq_page = FactoryGirl.create :page, :indicator => Page::PAGES[:faq], 
                              :content => 'Página sobre o FAQ do Liberdade.br'
  end

  scenario 'should show when is published' do
    visit '/'
    click_link 'Perguntas frequentes'
    page.should have_content 'Página sobre o FAQ do Liberdade.br'
    current_path.should == faq_path
  end

  context 'should not show when is not published' do
    background { @faq_page.update_attribute(:published, false) }

    scenario 'through index page' do
      visit '/'
      lambda { click_link 'Perguntas frequentes' }.should raise_error(Capybara::ElementNotFound)
    end

    scenario 'visiting about route' do
      lambda { visit faq_path }.should raise_error(ActionController::RoutingError)
    end
  end
end