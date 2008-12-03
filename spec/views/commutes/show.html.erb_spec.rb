require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/commutes/show.html.erb" do
  include CommutesHelper
  
  before(:each) do
    assigns[:commute] = @commute = stub_model(Commute,
      :name => "value for name",
      :distance_to => "1.5",
      :distance_from => "1.5",
      :auto_log => false,
      :days_of_the_week => "value for days_of_the_week"
    )
  end

  it "should render attributes in <p>" do
    render "/commutes/show.html.haml"
    response.should have_text(/value\ for\ name/)
    response.should have_text(/1\.5/)
    response.should have_text(/1\.5/)
    response.should have_text(/als/)
    response.should have_text(/value\ for\ days_of_the_week/)
  end
end

