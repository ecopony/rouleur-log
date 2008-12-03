require File.dirname(__FILE__) + '/../../spec_helper'

describe "/routes/new.html.erb" do
  include RoutesHelper
  
  before(:each) do
    @route = mock_model(Route)
    @route.stub!(:new_record?).and_return(true)
    @route.stub!(:name).and_return("MyString")
    @route.stub!(:description).and_return("MyString")
    assigns[:route] = @route
  end

  it "should render new form" do
    render "/routes/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", routes_path) do
      with_tag("input#route_name[name=?]", "route[name]")
      with_tag("input#route_description[name=?]", "route[description]")
    end
  end
end


