require File.dirname(__FILE__) + '/../spec_helper'

describe RidesController do
  describe "route generation" do

    it "should map { :controller => 'rides', :action => 'index' } to /rides" do
      route_for(:controller => "rides", :action => "index").should == "/rides"
    end
  
    it "should map { :controller => 'rides', :action => 'new' } to /rides/new" do
      route_for(:controller => "rides", :action => "new").should == "/rides/new"
    end
  
    it "should map { :controller => 'rides', :action => 'show', :id => 1 } to /rides/1" do
      route_for(:controller => "rides", :action => "show", :id => 1).should == "/rides/1"
    end
  
    it "should map { :controller => 'rides', :action => 'edit', :id => 1 } to /rides/1/edit" do
      route_for(:controller => "rides", :action => "edit", :id => 1).should == "/rides/1/edit"
    end
  
    it "should map { :controller => 'rides', :action => 'update', :id => 1} to /rides/1" do
      route_for(:controller => "rides", :action => "update", :id => 1).should == "/rides/1"
    end
  
    it "should map { :controller => 'rides', :action => 'destroy', :id => 1} to /rides/1" do
      route_for(:controller => "rides", :action => "destroy", :id => 1).should == "/rides/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'rides', action => 'index' } from GET /rides" do
      params_from(:get, "/rides").should == {:controller => "rides", :action => "index"}
    end
  
    it "should generate params { :controller => 'rides', action => 'new' } from GET /rides/new" do
      params_from(:get, "/rides/new").should == {:controller => "rides", :action => "new"}
    end
  
    it "should generate params { :controller => 'rides', action => 'create' } from POST /rides" do
      params_from(:post, "/rides").should == {:controller => "rides", :action => "create"}
    end
  
    it "should generate params { :controller => 'rides', action => 'show', id => '1' } from GET /rides/1" do
      params_from(:get, "/rides/1").should == {:controller => "rides", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'rides', action => 'edit', id => '1' } from GET /rides/1;edit" do
      params_from(:get, "/rides/1/edit").should == {:controller => "rides", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'rides', action => 'update', id => '1' } from PUT /rides/1" do
      params_from(:put, "/rides/1").should == {:controller => "rides", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'rides', action => 'destroy', id => '1' } from DELETE /rides/1" do
      params_from(:delete, "/rides/1").should == {:controller => "rides", :action => "destroy", :id => "1"}
    end
  end
end