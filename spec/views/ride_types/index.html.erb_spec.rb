require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/ride_types/index.html.haml" do
  include RideTypesHelper
  
  before(:each) do
    assigns[:ride_types] = [
      stub_model(RideType,
        :name => "value for name",
        :description => "value for description",
        :is_system_type => false
      ),
      stub_model(RideType,
        :name => "value for name",
        :description => "value for description",
        :is_system_type => false
      )
    ]
  end

  it "should render list of ride_types" do
    render "/ride_types/index.html.haml"
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "value for description", 2)
  end
end

