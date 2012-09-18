# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'show only published posts by author' do
  background do
    FactoryGirl.create :configuration
  end

  it 'through a show post' do
    @blog = FactoryGirl.create :blog, :description => 'any description'
    @post = FactoryGirl.create :post, :published => true,
                                      :published_at => Date.today,
                                      :blog => @blog,
                                      :approved_at => Date.today
    @other_post = FactoryGirl.create :post, :published => true,
                                            :published_at => Date.today,
                                            :title => 'My other post',
                                            :approved_at => Date.today
    @unpublished_post = FactoryGirl.create :post, :published => false,
                                                  :title => 'My unpublished post',
                                                  :blog => @blog
    visit post_path(@post)
    click_link 'Veja mais posts deste blog'
    current_path.should == posts_blog_path(@blog)
    page.should have_content(@post.title)
    page.should_not have_content(@other_post.title)
    page.should_not have_content(@unpublished_post.title)
  end
end