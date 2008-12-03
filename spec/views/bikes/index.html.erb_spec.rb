require File.dirname(__FILE__) + '/../../spec_helper'

describe "/bikes/index.html.erb" do
  include BikesHelper
  
  before(:each) do
    bike_98 = mock_model(Bike)
    bike_98.should_receive(:name).and_return("MyString")
    bike_98.should_receive(:description).and_return("MyString")
    bike_99 = mock_model(Bike)
    bike_99.should_receive(:name).and_return("MyString")
    bike_99.should_receive(:description).and_return("MyString")

    assigns[:bikes] = [bike_98, bike_99]
  end

  it "should render list of bikes" do
    render "/bikes/index.html.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

