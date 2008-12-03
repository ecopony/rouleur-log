require File.dirname(__FILE__) + '/../../spec_helper'

describe "/routes/index.html.erb" do
  include RoutesHelper
  
  before(:each) do
    route_98 = mock_model(Route)
    route_98.should_receive(:name).and_return("MyString")
    route_98.should_receive(:description).and_return("MyString")
    route_99 = mock_model(Route)
    route_99.should_receive(:name).and_return("MyString")
    route_99.should_receive(:description).and_return("MyString")

    assigns[:routes] = [route_98, route_99]
  end

  it "should render list of routes" do
    render "/routes/index.html.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

