require File.dirname(__FILE__) + '/../../spec_helper'

describe "/routes/show.html.erb" do
  include RoutesHelper
  
  before(:each) do
    @route = mock_model(Route)
    @route.stub!(:name).and_return("MyString")
    @route.stub!(:description).and_return("MyString")

    assigns[:route] = @route
  end

  it "should render attributes in <p>" do
    render "/routes/show.html.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

