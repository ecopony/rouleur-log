require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Commute do
  before(:each) do
    @valid_attributes = {
      :name => "Bakery",
      :distance_to => "1.5",
      :distance_from => "1.5",
      :auto_log => false,
      :days_of_the_week => "t, f",
      :start_date => Date.today,
      :end_date => Date.today
    }
  end

  it "should create a new instance given valid attributes" do
    Commute.create!(@valid_attributes)
  end
  
  it "should be valid" do
    @commute = Commute.create!(@valid_attributes)
    @commute.valid?.should be_true
  end
  
  it "should be invalid without a name" do
    @commute = Commute.create!(@valid_attributes)
    @commute.name = ""
    @commute.valid?.should be_false
  end
  
  it "should be invalid without a start date" do
    @commute = Commute.create!(@valid_attributes)
    @commute.start_date = ""
    @commute.valid?.should be_false
  end
  
  it "should be invalid without a distance to" do
    @commute = Commute.create!(@valid_attributes)
    @commute.distance_to = ""
    @commute.valid?.should be_false
  end
  
  it "should be invalid without a distance from" do
    @commute = Commute.create!(@valid_attributes)
    @commute.distance_from = ""
    @commute.valid?.should be_false
  end

end
