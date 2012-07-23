require 'spec_helper'

describe Blog do
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
	end

  context 'get new posts from feed and' do
    before(:all) do
      @blog = FactoryGirl.create :blog
      @entry = Feedzirra::Parser::RSSEntry.new
      @parser = Feedzirra::Parser::RSS.new
    end

    it 'save the published today ones' do
      @entry.stub(:published).and_return(DateTime.now)
      @parser.stub(:entries).and_return([@entry])
      Feedzirra::Feed.stub(:fetch_and_parse).with(@blog.rss).and_return(@parser)
      Post.should_receive(:create_from_feed).with(@entry)
      @blog.get_new_posts
    end

    it 'do nothing if it has no one published today' do
      @entry.stub(:published).and_return(DateTime.yesterday)
      @parser.stub(:entries).and_return([@entry])
      Feedzirra::Feed.stub(:fetch_and_parse).with(@blog.rss).and_return(@parser)
      Post.should_not_receive(:create_from_feed).with(@entry)
      @blog.get_new_posts
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
