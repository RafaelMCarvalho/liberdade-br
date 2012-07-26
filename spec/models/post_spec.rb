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
end
