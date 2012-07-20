require 'spec_helper'

describe Blog do
	context 'validations' do
		context 'name' do
		  it { should have_valid(:name).when('blog da algorich') }
		  it { should_not have_valid(:name).when('', nil) }
		end

		context 'link' do
		  it { should have_valid(:link).when('http://blog.algorich.com.br') }
		  it { should have_valid(:link).when('blog.algorich.com.br') }
		  it { should_not have_valid(:link).when('', nil, 'foo') }
		end
	end
end
