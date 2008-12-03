require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/ride_types/show.html.haml" do
  include RideTypesHelper
  
  before(:each) do
    assigns[:ride_type] = @ride_type = stub_model(RideType,
      :name => "value for name",
      :description => "value for description",
      :is_system_type => false
    )
  end

  it "should render attributes in <p>" do
    render "/ride_types/show.html.haml"
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
  end
end

