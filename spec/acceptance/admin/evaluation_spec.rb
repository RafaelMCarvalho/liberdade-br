# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'manage posts' do
  background do
    FactoryGirl.create :configuration
    @user = FactoryGirl.create :user, :role => :moderator
    login(@user.email, '123456')
  end

  context 'evaluate a post', :js => true do
    it 'approve/reprove a post first time' do
      @post = FactoryGirl.create :post, :published_at => Date.today
      visit "/posts/#{@post.id}"

      page.should_not have_xpath("//a[@id='approve_post'][@class='active']")
      page.should_not have_xpath("//a[@id='reprove_post'][@class='active']")
      PostEvaluation.all.count.should == 0

      click_link 'Aprovar'
      sleep 2
      page.should have_xpath("//a[@id='approve_post'][@class='active']")
      page.should_not have_xpath("//a[@id='reprove_post'][@class='active']")
      @evaluation = PostEvaluation.where('user_id = ? and post_id = ?', @user.id, @post.id).first
      @evaluation.should_not be_nil
      @evaluation.approve.should be_true

      click_link 'Reprovar'
      page.should_not have_xpath("//a[@id='approve_post'][@class='active']")
      page.should have_xpath("//a[@id='reprove_post'][@class='active']")
      @evaluation.reload
      @evaluation.approve.should be_false
    end

    it 'change evaluation' do
      @post = FactoryGirl.create :post, :published_at => Date.today
      @evaluation = FactoryGirl.create :post_evaluation, :user_id => @user.id,
        :post_id => @post.id, :approve => true
      visit "/posts/#{@post.id}"

      page.should have_xpath("//a[@id='approve_post'][@class='active']")
      page.should_not have_xpath("//a[@id='reprove_post'][@class='active']")
      PostEvaluation.all.count.should == 1
      @evaluation = PostEvaluation.where('user_id = ? and post_id = ?', @user.id, @post.id).first

      click_link 'Aprovar'
      page.should have_xpath("//a[@id='approve_post'][@class='active']")
      page.should_not have_xpath("//a[@id='reprove_post'][@class='active']")
      @evaluation.reload
      @evaluation.approve.should be_true

      click_link 'Reprovar'
      page.should_not have_xpath("//a[@id='approve_post'][@class='active']")
      page.should have_xpath("//a[@id='reprove_post'][@class='active']")
      @evaluation.reload
      @evaluation.approve.should be_false
    end

    context 'cannot evaluate as another user' do
      background do
        @another_user = FactoryGirl.create :user
        @post = FactoryGirl.create :post, :published_at => Date.today
      end

      it 'at first time' do
        visit "/admin/post/#{@post.id}/approve/#{@another_user.id}"
        PostEvaluation.all.count.should == 0
        visit "/admin/post/#{@post.id}/reprove/#{@another_user.id}"
        PostEvaluation.all.count.should == 0
      end

      it 'while updating' do
        @evaluation = FactoryGirl.create :post_evaluation, :user_id => @another_user.id,
          :post_id => @post.id, :approve => true

        visit "/admin/post/#{@post.id}/reprove/#{@another_user.id}"
        @evaluation.reload.approve.should be_true

        # Set approve value to false
        @evaluation.update_attributes(:approve => false)

        visit "/admin/post/#{@post.id}/approve/#{@another_user.id}"
        @evaluation.reload.approve.should be_false
      end
    end
  end
end
