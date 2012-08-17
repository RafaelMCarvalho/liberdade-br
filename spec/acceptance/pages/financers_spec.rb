# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'financers page' do
  background do
    FactoryGirl.create :configuration
    @financers_page = FactoryGirl.create :page, :indicator => Page::PAGES[:financers], 
                              :content => 'Página sobre os financiadores do Liberdade.br'
  end

  scenario 'should show when is published' do
    visit '/'
    click_link 'Veja a lista completa das pessoas que financiaram esta iniciativa'
    page.should have_content 'Página sobre os financiadores do Liberdade.br'
    current_path.should == financers_path
  end

  context 'should not show when is not published' do
    background { @financers_page.update_attribute(:published, false) }

    scenario 'through index page' do
      visit '/'
      lambda { click_link 'Veja a lista completa das pessoas que financiaram esta iniciativa' }.should raise_error(Capybara::ElementNotFound)
    end

    scenario 'visiting about route' do
      lambda { visit financers_path }.should raise_error(ActionController::RoutingError)
    end
  end
end