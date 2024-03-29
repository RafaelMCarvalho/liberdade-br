# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Post do
  context 'validations' do
    context 'title' do
      it { should have_valid(:title).when('Foo post') }
      it { should_not have_valid(:title).when('', nil) }
    end
    context 'when someone send a post through post#send (blog is nil)' do
      it 'authors cant be blank' do
        post = FactoryGirl.build :post, :blog => nil, :authors => []
        post.save.should be_false
      end
      it 'content cant be blank' do
        post = FactoryGirl.build :post, :blog => nil, :content => ''
        post.save.should be_false
      end
    end
  end

  context 'should be published and set approved_at' do
    it 'when approval rate is greater than or equals to 20% and reproval rate lower than 20%' do
      post = FactoryGirl.create :post, :published => false
      post.approval_rate = 20.0
      post.reproval_rate = 19.9
      post.save
      post.reload.published.should be_true
      post.approved_at.should == Date.today
    end
  end

  context 'should be unpublished' do
    it 'when reproval rate is greater than or equals to 20%' do
      post = FactoryGirl.create :post, :published => true
      post.reproval_rate = 20.0
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
      I18n.l(@post.reload.last_evaluation_date).should == I18n.l(DateTime.now)
      I18n.l(@user.last_evaluation_date) == I18n.l(DateTime.now)
    end

    it 'when some associated evaluation is created' do
      FactoryGirl.create :post_evaluation, :user => @user2,
        :post => @post, :approve => true
      I18n.l(@post.reload.last_evaluation_date).should == I18n.l(DateTime.now)
      I18n.l(@user.last_evaluation_date) == I18n.l(DateTime.now)
    end

    it 'when some user is created and evaluate the post' do
      user = FactoryGirl.create :user
      FactoryGirl.create :post_evaluation, :post => @post, :user => user
      I18n.l(@post.reload.last_evaluation_date).should == I18n.l(DateTime.now)
      I18n.l(@user.last_evaluation_date) == I18n.l(DateTime.now)
    end

    after(:each) do
      @post.reload
      (@post.approval_rate != @old_approval_rate or
        @post.reproval_rate != @old_reproval_rate).should be_true
    end
  end

  context 'moderator_counter' do
    it 'should initialize with actual moderators(users) count and  update to total users votes when it exceeds the moderator counter' do
      user1 = FactoryGirl.create :user
      user2 = FactoryGirl.create :user
      post = FactoryGirl.create :post
      post.moderator_counter.should == 2
      user3 = FactoryGirl.create :user
      FactoryGirl.create :post_evaluation, :user => user1, :post => post
      FactoryGirl.create :post_evaluation, :user => user2, :post => post
      post.moderator_counter.should == 2
      FactoryGirl.create :post_evaluation, :user => user3, :post => post
      post.reload.moderator_counter.should == 3
    end

    it 'should evaluate post based on moderator_counter' do
      user1 = FactoryGirl.create :user
      user2 = FactoryGirl.create :user
      post = FactoryGirl.create :post
      FactoryGirl.create :post_evaluation, :user => user1, :post => post, :approve => true
      FactoryGirl.create :post_evaluation, :user => user2, :post => post, :approve => true
      post.reload.approval_rate.should == 100.0
      user3 = FactoryGirl.create :user
      post.reload.approval_rate.should == 100.0
      FactoryGirl.create :post_evaluation, :user => user3, :post => post, :approve => false
      post.reload.approval_rate.round(1).should == 66.7
    end
  end

  context 'should create a post from a feed entry that includes at least one of configuration categories' do
    # I'm using before(:each) because stub isn't supported on before(:create)
    # more info on https://github.com/rspec/rspec-mocks/issues/92#issuecomment-3178470
    before(:each) do
      Category.delete_all
      Post.delete_all
      category = FactoryGirl.create :category, :name => 'liberalismo'
      configurarion = FactoryGirl.create :configuration, :categories => [category]
      @entry = stub(
        :title => 'Sobre corporações e leis de responsabilidade limitada',
        :url => 'http://depositode.blogspot.com/2012/06/sobre-corporacoes-e-leis-de.html',
        :content => 'Some text very big'*500,
        :published => Time.parse('Jul 25 13:25:00 -0300 2012'),
        :categories => ['LIBERALISMO', 'RESPONSABILIDADE LIMITADA', 'LIBERDADE.BR'],
        :author => 'Richard  , Leonard   '
      )
      Post.create_from_feed_entry(@entry, (FactoryGirl.create :blog))
      @post = Post.last
    end

    it 'with the right title, url, content and date' do
      @post.title.should == @entry.title
      @post.url.should == @entry.url
      @post.content.should == @entry.content
      @post.published_at.should == @entry.published.to_s
    end

    it 'with the rigth categories (creating the nonexistent ones)' do
      categories = Category.all
      categories.should have(3).categories
      categories.collect(&:name).should include('liberalismo', 'responsabilidade limitada', 'liberdade.br')
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

  it 'should not create a post from a feed entry that doesnt includes at least one of configuration categories' do
    Category.delete_all
    Post.delete_all
    category = FactoryGirl.create :category, :name => 'foo'
    configuration = FactoryGirl.create :configuration, :categories => [category]

    entry = stub(
      :title => 'Sobre corporações e leis de responsabilidade limitada',
      :url => 'http://depositode.blogspot.com/2012/06/sobre-corporacoes-e-leis-de.html',
      :content => 'Some text very big'*500,
      :published => Time.parse('Jul 25 13:25:00 -0300 2012'),
      :categories => ['LIBERALISMO', 'RESPONSABILIDADE LIMITADA'], # without foo category
      :author => 'Richard  , Leonard   '
    )
    Post.create_from_feed_entry(entry, (FactoryGirl.create :blog))

    Post.all.should have(0).posts
  end

  it 'should create a post from a feed entry that includes any category when configuration categories is empty' do
    Category.delete_all
    Post.delete_all
    configurarion = FactoryGirl.create :configuration, :categories => [] # blank categories list
    entry = stub(
      :title => 'Sobre corporações e leis de responsabilidade limitada',
      :url => 'http://depositode.blogspot.com/2012/06/sobre-corporacoes-e-leis-de.html',
      :content => 'Some text very big'*500,
      :published => Time.parse('Jul 25 13:25:00 -0300 2012'),
      :categories => ['zigzagfoocategory'], # non selected category
      :author => 'Richard  , Leonard   '
    )
    Post.create_from_feed_entry(entry, (FactoryGirl.create :blog))

    Post.all.should have(1).posts
    Author.all.should have(2).authors
    Category.all.should have(1).category
  end

  context 'should create a post from a new post page' do
    before(:each) do
      @params = {
        :title => 'Sobre corporações e leis de responsabilidade limitada',
        :url => 'http://depositode.blogspot.com/2012/06/sobre-corporacoes-e-leis-de.html',
        :content => 'Some text very big'*500,
        :categories => 'LIBERALISMO  , RESPONSABILIDADE LIMITADA  ',
        :authors => 'Richard  , Leonard   '
      }
      @post = Post.build_from_new_post_page(@params)
      @post.save
    end

    it 'with the right title and content' do
      @post.title.should == @params[:title]
      @post.content.should == @params[:content]
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

  it 'should return all posts published by admin or moderation, except unpublished by admin ones' do
    post1 = FactoryGirl.create :post, :criterion_for_publication => Post::CRITERION_FOR_PUBLICATION[:by_moderation], :published => true
    post2 = FactoryGirl.create :post, :criterion_for_publication => Post::CRITERION_FOR_PUBLICATION[:by_moderation], :published => false

    post3 = FactoryGirl.create :post, :criterion_for_publication => Post::CRITERION_FOR_PUBLICATION[:always_published], :published => true
    post4 = FactoryGirl.create :post, :criterion_for_publication => Post::CRITERION_FOR_PUBLICATION[:always_published], :published => false

    post5 = FactoryGirl.create :post, :criterion_for_publication => Post::CRITERION_FOR_PUBLICATION[:always_unpublished], :published => true
    post6 = FactoryGirl.create :post, :criterion_for_publication => Post::CRITERION_FOR_PUBLICATION[:always_unpublished], :published => false

    Post.published.should include(post1, post3, post4)
    Post.published.should_not include(post2, post5, post6)
  end

  it 'should return similar published posts (that share at least one category)' do
    category1 = FactoryGirl.create :category, :name => 'Category1'
    category2 = FactoryGirl.create :category, :name => 'Category2'
    category3 = FactoryGirl.create :category, :name => 'Category3'
    post1 = FactoryGirl.create :post, :categories => [category1], :criterion_for_publication => Post::CRITERION_FOR_PUBLICATION[:always_published], :published => true
    post2 = FactoryGirl.create :post, :categories => [category1, category2, category3], :criterion_for_publication => Post::CRITERION_FOR_PUBLICATION[:always_published], :published => true
    post3 = FactoryGirl.create :post, :categories => [category3], :criterion_for_publication => Post::CRITERION_FOR_PUBLICATION[:always_published], :published => true

    post4 = FactoryGirl.create :post, :categories => [category1, category2, category3], :criterion_for_publication => Post::CRITERION_FOR_PUBLICATION[:always_unpublished], :published => false

    post1.similar.should include(post2)
    post2.similar.should include(post1, post3)
    post3.similar.should include(post2)

    post1.similar.should_not include(post1, post3, post4)
    post2.similar.should_not include(post2, post4)
    post3.similar.should_not include(post3, post1, post4)
  end
end
