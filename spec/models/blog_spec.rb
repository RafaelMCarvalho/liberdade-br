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
      @today_entry1 = Feedzirra::Parser::RSSEntry.new
      @today_entry2 = Feedzirra::Parser::RSSEntry.new
      @past_entry1 = Feedzirra::Parser::RSSEntry.new
      @past_entry2 = Feedzirra::Parser::RSSEntry.new
      @parser = Feedzirra::Parser::RSS.new
    end

    def stub_entries_time
      @today_entry1.stub(:published).and_return(DateTime.now - 5.hours)
      @today_entry2.stub(:published).and_return(DateTime.now)
      @past_entry1.stub(:published).and_return(DateTime.now - 1.day)
      @past_entry2.stub(:published).and_return(DateTime.now - 3.days)
    end

    it 'save the published today ones' do
      stub_entries_time
      all_entries = [@past_entry1, @past_entry2, @today_entry1, @today_entry2]
      @parser.stub(:entries).and_return(all_entries)
      Feedzirra::Feed.stub(:fetch_and_parse).with(@blog.rss).and_return(@parser)
      Post.should_receive(:create_from_feed).with(@today_entry1)
      Post.should_receive(:create_from_feed).with(@today_entry2)
      @blog.get_new_posts
    end

    it 'do nothing if it has no one published today' do
      stub_entries_time
      @parser.stub(:entries).and_return([@past_entry1, @past_entry2])
      Feedzirra::Feed.stub(:fetch_and_parse).with(@blog.rss).and_return(@parser)
      Post.should_not_receive(:create_from_feed)
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
