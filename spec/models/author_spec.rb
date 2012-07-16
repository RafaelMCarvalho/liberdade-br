require 'spec_helper'

describe Author do
	context 'validations' do
		context 'name' do
		  it { should have_valid(:name).when('Zé do post') }
		  it { should_not have_valid(:name).when('', nil) }
		end
	end
end
