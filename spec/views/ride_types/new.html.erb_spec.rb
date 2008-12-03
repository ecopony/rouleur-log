require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/ride_types/new.html.haml" do
  include RideTypesHelper
  
  before(:each) do
    assigns[:ride_type] = stub_model(RideType,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description",
      :is_system_type => false
    )
  end

  it "should render new form" do
    render "/ride_types/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", ride_types_path) do
      with_tag("input#ride_type_name[name=?]", "ride_type[name]")
      with_tag("input#ride_type_description[name=?]", "ride_type[description]")
    end
  end
end


