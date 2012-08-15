# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Post do
  context 'validations' do
    context 'title' do
      it { should have_valid(:title).when('Foo post') }
      it { should_not have_valid(:title).when('', nil) }
    end
  end

  context 'should be published' do
    it 'when approval rate is greater than or equals to 20% and reproval rate lower than 50%' do
      post = FactoryGirl.create :post, :published => false
      post.approval_rate = 20.0
      post.reproval_rate = 49.9
      post.save
      post.reload.published.should be_true
    end
  end

  context 'should be unpublished' do
    it 'when reproval rate is greater than or equals to 50%' do
      post = FactoryGirl.create :post, :published => true
      post.reproval_rate = 50.0
      post.save
      post.reload.published.should be_false
    end
  end

  context 'should update evaluation rates when' do
    before(:each) do
      @user = FactoryGirl.create :user
      @user2 = FactoryGirl.create :user
      @post = FactoryGirl.create :post
      @post_evaluation = FactoryGirl.create :post_evaluation, :user => @user,
        :post => @post, :approve => true
      @post.reload
      @old_approval_rate = @post.approval_rate
      @old_reproval_rate = @post.reproval_rate
    end

    it 'when some associated evaluation changes' do
      @post_evaluation.update_attributes(:approve => false)
    end

    it 'when some associated evaluation is created' do
      FactoryGirl.create :post_evaluation, :user => @user2,
        :post => @post, :approve => true
    end

    it 'when some user is created' do
      FactoryGirl.create :user
    end

    after(:each) do
      @post.reload
      (@post.approval_rate != @old_approval_rate or
        @post.reproval_rate != @old_reproval_rate).should be_true
    end
  end

  context 'should create a post from a feed entry' do
    # I'm using before(:each) because stub isn't supported on before(:create)
    # more info on https://github.com/rspec/rspec-mocks/issues/92#issuecomment-3178470
    before(:each) do
      @entry = stub(
        :title => 'Sobre corporações e leis de responsabilidade limitada',
        :url => 'http://depositode.blogspot.com/2012/06/sobre-corporacoes-e-leis-de.html',
        :content => 'Some text very big'*500,
        :published => Time.parse('Jul 25 13:25:00 -0300 2012'),
        :categories => ['LIBERALISMO', 'RESPONSABILIDADE LIMITADA'],
        :author => 'Richard  , Leonard   '
      )
      Post.create_from_feed_entry(@entry, (FactoryGirl.create :blog))
      @post = Post.last
    end

    it 'with the right title, url, content and date' do
      @post.title.should == @entry.title
      @post.url.should == @entry.url
      @post.content.should == @entry.content
      @post.published_at.should == Date.parse(@entry.published.to_s)
    end

    it 'with the rigth categories (creating the nonexistent ones)' do
      Category.create(:name => 'liberalismo')
      categories = Category.all
      categories.should have(2).categories
      categories.collect(&:name).should include('liberalismo', 'responsabilidade limitada')
      @post.categories.should include(*categories)
    end

    it 'with the rigth authors (creating the nonexistent ones)' do
      Author.create(:name => 'Leonard')
      authors = Author.all
      authors.should have(2).authors
      authors.collect(&:name).should include('Richard', 'Leonard')
      @post.authors.should include(*authors)
    end
  end
end
