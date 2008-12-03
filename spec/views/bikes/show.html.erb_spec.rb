require File.dirname(__FILE__) + '/../../spec_helper'

describe "/bikes/show.html.erb" do
  include BikesHelper
  
  before(:each) do
    @bike = mock_model(Bike)
    @bike.stub!(:name).and_return("MyString")
    @bike.stub!(:description).and_return("MyString")

    assigns[:bike] = @bike
  end

  it "should render attributes in <p>" do
    render "/bikes/show.html.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

