require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/ride_types/edit.html.haml" do
  include RideTypesHelper
  
  before(:each) do
    assigns[:ride_type] = @ride_type = stub_model(RideType,
      :new_record? => false,
      :name => "value for name",
      :description => "value for description",
      :is_system_type => false
    )
  end

  it "should render edit form" do
    render "/ride_types/edit.html.haml"
    
    response.should have_tag("form[action=#{ride_type_path(@ride_type)}][method=post]") do
      with_tag('input#ride_type_name[name=?]', "ride_type[name]")
      with_tag('input#ride_type_description[name=?]', "ride_type[description]")
    end
  end
end


