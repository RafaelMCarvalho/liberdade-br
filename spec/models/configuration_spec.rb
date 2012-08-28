# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Configuration do
  context 'validations' do
    context 'email' do
      it { should_not have_valid(:email).when('') }
      it { should_not have_valid(:email).when(nil) }
      it { should_not have_valid(:email).when('contato@empresa') }
      it { should have_valid(:email).when('contato@empresa.com') }
    end
    context 'site_url' do
      it { should have_valid(:site_url).when('http://blog.algorich.com.br') }
      it { should have_valid(:site_url).when('blog.algorich.com.br') }
      it { should_not have_valid(:site_url).when('foo') }
    end
    context 'facebook' do
      it { should have_valid(:facebook).when('http://blog.algorich.com.br') }
      it { should have_valid(:facebook).when('blog.algorich.com.br') }
      it { should_not have_valid(:facebook).when('foo') }
    end
    context 'twitter' do
      it { should have_valid(:twitter).when('http://blog.algorich.com.br') }
      it { should have_valid(:twitter).when('blog.algorich.com.br') }
      it { should_not have_valid(:twitter).when('foo') }
    end
    context 'ad_url' do
      it { should have_valid(:ad_url).when('http://blog.algorich.com.br') }
      it { should have_valid(:ad_url).when('blog.algorich.com.br') }
      it { should_not have_valid(:ad_url).when('foo') }
    end
    context 'realization_url' do
      it { should have_valid(:realization_url).when('http://blog.algorich.com.br') }
      it { should have_valid(:realization_url).when('blog.algorich.com.br') }
      it { should_not have_valid(:realization_url).when('foo') }
    end
  end
end
