# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Category do
  context 'validations' do
    context 'name' do
      it { should have_valid(:name).when('dev') }
      it { should_not have_valid(:name).when('', nil) }

      it 'should be uniq' do
        Category.create :name => 'liberalismo'
        c = Category.new :name => 'liberalismo'
        c.save.should be_false
        c.errors[:name].any?.should be_true
      end
    end
  end

  it 'should return only published posts' do
    published_post = FactoryGirl.create :post, :published => true
    unpublished_post = FactoryGirl.create :post, :published => false
    category = FactoryGirl.create :category, :posts => [published_post, unpublished_post]
    category.published_posts.should == [published_post]
  end

  it 'name should be downcased' do
    c = Category.create(:name => 'LIBERALISMO')
    c.name.should == 'liberalismo'

    c.update_attribute(:name, 'Liberalismo')
    c.name.should == 'liberalismo'
  end

  it 'should get or create a new one' do
    c = Category.get_or_create_by_name('liberalismo')
    c.name == 'liberalismo'
    Category.all.should have(1).category

    c = Category.get_or_create_by_name('economia')
    c.name == 'economia'
    Category.all.should have(2).category

    c = Category.get_or_create_by_name('liberalismo')
    c.name == 'liberalismo'
    Category.all.should have(2).category
  end
end
