# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'manage posts' do
  background do
    FactoryGirl.create :configuration
    @moderator_user = FactoryGirl.create :user, :role => :moderator
    login(@moderator_user.email, '123456')
    @post = FactoryGirl.create :post
  end

  it 'cannot create/update/delete a post' do
    lambda {
      visit '/admin/post/new'
    }.should raise_error CanCan::AccessDenied

    lambda {
      visit "/admin/post/#{@post.id}/edit"
    }.should raise_error CanCan::AccessDenied

    lambda {
       visit "/admin/post/#{@post.id}/delete"
    }.should raise_error CanCan::AccessDenied
  end
end
