require 'spec_helper'

describe Category do
	context 'validations' do
		context 'name' do
		  it { should have_valid(:name).when('dev') }
		  it { should_not have_valid(:name).when('', nil) }
		end
	end
end
