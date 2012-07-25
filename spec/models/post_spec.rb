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
    it 'with all atributes' do
      entry = Feedzirra::Parser::RSSEntry.new
      entry.stub(
        :title => 'Sobre corporações e leis de responsabilidade limitada',
        :url => 'http://depositode.blogspot.com/feeds/posts/default',
        :author => 'Richard',
        :content => 'Some text very big'*500,
        :published => Time.parse('Jul 25 13:25:00 -0300 2012'),
        :categories => ["LIBERALISMO", "RESPONSABILIDADE LIMITADA"]
      )
    end
  end
end