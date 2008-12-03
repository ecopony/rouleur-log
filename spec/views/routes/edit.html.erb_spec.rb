require File.dirname(__FILE__) + '/../../spec_helper'

describe "/routes/edit.html.erb" do
  include RoutesHelper
  
  before do
    @route = mock_model(Route)
    @route.stub!(:name).and_return("MyString")
    @route.stub!(:description).and_return("MyString")
    assigns[:route] = @route
  end

  it "should render edit form" do
    render "/routes/edit.html.haml"
    
    response.should have_tag("form[action=#{route_path(@route)}][method=post]") do
      with_tag('input#route_name[name=?]', "route[name]")
      with_tag('input#route_description[name=?]', "route[description]")
    end
  end
end


