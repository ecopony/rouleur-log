require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/commutes/new.html.erb" do
  include CommutesHelper
  
  before(:each) do
    assigns[:commute] = stub_model(Commute,
      :new_record? => true,
      :name => "value for name",
      :distance_to => "1.5",
      :distance_from => "1.5",
      :auto_log => false,
      :days_of_the_week => "value for days_of_the_week"
    )
  end

  it "should render new form" do
    render "/commutes/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", commutes_path) do
      with_tag("input#commute_name[name=?]", "commute[name]")
      with_tag("input#commute_distance_to[name=?]", "commute[distance_to]")
      with_tag("input#commute_distance_from[name=?]", "commute[distance_from]")
      with_tag("input#commute_auto_log[name=?]", "commute[auto_log]")
      with_tag("input#commute_days_of_the_week[name=?]", "commute[days_of_the_week]")
    end
  end
end


