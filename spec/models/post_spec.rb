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
end
