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

  it 'name should be downcased' do
    c = Category.create(:name => 'LIBERALISMO')
    c.name.should == 'liberalismo'

    c.update_attribute(:name, 'Liberalismo')
    c.name.should == 'liberalismo'
  end
end
