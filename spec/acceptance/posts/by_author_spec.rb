# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'show posts by author' do
  background do
    FactoryGirl.create :configuration
  end

  it 'through a show post' do
    @post = FactoryGirl.create :post, :published => true, :published_at => Date.today
    @other_post = FactoryGirl.create :post, :published => true, :published_at => Date.today
    @author = FactoryGirl.create :author, :posts => [@post, @other_post]
    visit post_path(@post)
    click_link @author.name
    # current_path.should == posts_author_path()
  end
end