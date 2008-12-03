require File.dirname(__FILE__) + '/../../spec_helper'

describe "/bikes/new.html.erb" do
  include BikesHelper
  
  before(:each) do
    @bike = mock_model(Bike)
    @bike.stub!(:new_record?).and_return(true)
    @bike.stub!(:name).and_return("MyString")
    @bike.stub!(:description).and_return("MyString")
    assigns[:bike] = @bike
  end

  it "should render new form" do
    render "/bikes/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", bikes_path) do
      with_tag("input#bike_name[name=?]", "bike[name]")
      with_tag("input#bike_description[name=?]", "bike[description]")
    end
  end
end


