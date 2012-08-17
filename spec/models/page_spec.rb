# -*- encoding : utf-8 -*-

require 'spec_helper'

describe Page do
  it 'should return the page' do
    @page = FactoryGirl.create :page, :indicator => Page::PAGES[:about]
    Page.get_page(:about).should == @page
  end

  context 'validations' do
    it { should_not have_valid(:title).when('') }
    it { should_not have_valid(:title).when(nil) }
    it { should have_valid(:title).when('Algum título') }
  end
end

