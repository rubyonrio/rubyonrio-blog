require File.dirname(__FILE__) + '/../spec_helper'

describe Member do

  before(:each) do
    @member = Member.new(:username => "Username")
  end


  it 'should not create member without username' do
    @member.username=nil
    @member.should_not be_valid
  end

  it 'should not create member without username' do
    @member.should be_valid
  end

end
