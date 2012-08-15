# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Author do
  it 'should return only published posts' do
    published_post = FactoryGirl.create :post, :published => true    
    unpublished_post = FactoryGirl.create :post, :published => false
    author = FactoryGirl.create :author, :posts => [published_post, unpublished_post]
    author.published_posts.should == [published_post]
  end

  context 'validations' do
    context 'name' do
      it { should have_valid(:name).when('Zé do post') }
      it { should_not have_valid(:name).when('', nil) }

      it 'should be uniq' do
        Author.create :name => 'Richard'
        c = Author.new :name => 'Richard'
        c.save.should be_false
        c.errors[:name].any?.should be_true
      end
    end
  end

  it 'should get or create a new one' do
    c = Author.get_or_create_by_name('Richard')
    c.name == 'Richard'
    Author.all.should have(1).author

    c = Author.get_or_create_by_name('Leonard')
    c.name == 'Leonard'
    Author.all.should have(2).author

    c = Author.get_or_create_by_name('Richard')
    c.name == 'Richard'
    Author.all.should have(2).author
  end
end
