require File.dirname(__FILE__) + '/../../spec_helper'

describe "/bikes/edit.html.erb" do
  include BikesHelper
  
  before do
    @bike = mock_model(Bike)
    @bike.stub!(:name).and_return("MyString")
    @bike.stub!(:description).and_return("MyString")
    assigns[:bike] = @bike
  end

  it "should render edit form" do
    render "/bikes/edit.html.haml"
    
    response.should have_tag("form[action=#{bike_path(@bike)}][method=post]") do
      with_tag('input#bike_name[name=?]', "bike[name]")
      with_tag('input#bike_description[name=?]', "bike[description]")
    end
  end
end


