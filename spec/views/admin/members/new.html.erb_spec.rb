require File.dirname(__FILE__) + '/../../../spec_helper'

describe "admin/members/new.html.erb" do
  before(:each) do
    assign(:member, stub_model(Member,
      :username => "MyString"
    ).as_new_record)
  end

  it "renders new member form" do
    render :template => '/admin/members/new.html.erb'

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_members_path, :method => "post" do
      assert_select "input#member_username", :name => "member[username]"
    end
  end
end
