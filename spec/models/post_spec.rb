# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Post do
  context 'validations' do
    context 'title' do
      it { should have_valid(:title).when('Foo post') }
      it { should_not have_valid(:title).when('', nil) }
    end
    context 'content' do
      it { should have_valid(:content).when('Foo content') }
      it { should_not have_valid(:content).when('', nil) }
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
      Post.create_from_feed_entry(@entry)
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