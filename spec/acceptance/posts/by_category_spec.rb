# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'show only published posts by category' do
  background do
    FactoryGirl.create :configuration
  end

  it 'through a show post' do
    @post = FactoryGirl.create :post, :published => true, :published_at => Date.today, :approved_at => Date.today
    @other_post = FactoryGirl.create :post, :published => true, :published_at => Date.today, :approved_at => Date.today
    @unpublished_post = FactoryGirl.create :post, :published => false, :title => 'My unpublished post'
    @category = FactoryGirl.create :category, :posts => [@post, @other_post], :name => 'Foobar category'
    visit post_path(@post)
    click_link @category.name
    current_path.should == posts_category_path(@category)
    page.should have_content(@post.title)
    page.should have_content(@other_post.title)
    page.should_not have_content(@unpublished_post.title)
  end
end