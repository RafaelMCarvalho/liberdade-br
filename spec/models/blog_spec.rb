# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Blog do
  it 'should return only published posts' do
    blog = FactoryGirl.create :blog
    published_post = FactoryGirl.create :post, :published => true, :blog => blog
    unpublished_post = FactoryGirl.create :post, :published => false, :blog => blog
    blog.published_posts.should == [published_post]
  end

	context 'validations' do
		context 'name' do
		  it { should have_valid(:name).when('blog da algorich') }
		  it { should_not have_valid(:name).when('', nil) }
		end

		context 'link' do
		  it { should have_valid(:link).when('http://blog.algorich.com.br') }
		  it { should have_valid(:link).when('blog.algorich.com.br') }
		  it { should_not have_valid(:link).when('', nil, 'foo') }
		end

    context 'rss' do
      it { should have_valid(:rss).when('http://blog.algorich.com.br/rss') }
      it { should have_valid(:rss).when('blog.algorich.com.br') }
      it { should_not have_valid(:rss).when('', nil, 'foo') }
    end
	end

  context 'get new posts from feed and' do
    before(:all) do
      @blog = FactoryGirl.create :blog
    end

    def stub_entries
      @today_entry1 = stub(:published => Time.now - 5.hours)
      @today_entry2 = stub(:published => Time.now)
      @past_entry1 = stub(:published => Time.now - 1.day)
      @past_entry2 = stub(:published => Time.now - 3.days)
    end

    it 'save the published today ones' do
      stub_entries
      Blog.should_receive(:all).and_return([@blog])
      all_entries = [@past_entry1, @past_entry2, @today_entry1, @today_entry2]
      parser = stub(:entries => all_entries)
      Feedzirra::Feed.stub(:fetch_and_parse).with(@blog.rss).and_return(parser)
      Post.should_receive(:create_from_feed_entry).with(@today_entry1, @blog)
      Post.should_receive(:create_from_feed_entry).with(@today_entry2, @blog)
      Blog.get_new_posts
    end

    it 'do nothing if it has no one published today' do
      stub_entries
      Blog.should_receive(:all).and_return([@blog])
      parser = stub(:entries => [@past_entry1, @past_entry2])
      Feedzirra::Feed.stub(:fetch_and_parse).with(@blog.rss).and_return(parser)
      Post.should_not_receive(:create_from_feed_entry)
      Blog.get_new_posts
    end
  end

  context 'when deleted' do
    it 'should destroy all your dependents' do
      @blog = FactoryGirl.create :blog
      post1 = FactoryGirl.create :post, :blog => @blog
      post2 = FactoryGirl.create :post, :blog => @blog
      @blog.posts.should == [post1, post2]
      @blog.destroy
      Post.all.length.should == 0
    end
  end
end
