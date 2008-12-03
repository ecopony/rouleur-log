require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/commutes/index.html.erb" do
  include CommutesHelper
  
  before(:each) do
    assigns[:commutes] = [
      stub_model(Commute,
        :name => "value for name",
        :distance_to => "1.5",
        :distance_from => "1.5",
        :auto_log => false,
        :days_of_the_week => "value for days_of_the_week"
      ),
      stub_model(Commute,
        :name => "value for name",
        :distance_to => "1.5",
        :distance_from => "1.5",
        :auto_log => false,
        :days_of_the_week => "value for days_of_the_week"
      )
    ]
  end

  it "should render list of commutes" do
    render "/commutes/index.html.haml"
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "1.5", 2)
    response.should have_tag("tr>td", "1.5", 2)
  end
end

