require File.dirname(__FILE__) + '/../spec_helper'

describe BikesController do
  describe "route generation" do

    it "should map { :controller => 'bikes', :action => 'index' } to /bikes" do
      route_for(:controller => "bikes", :action => "index").should == "/bikes"
    end
  
    it "should map { :controller => 'bikes', :action => 'new' } to /bikes/new" do
      route_for(:controller => "bikes", :action => "new").should == "/bikes/new"
    end
  
    it "should map { :controller => 'bikes', :action => 'show', :id => 1 } to /bikes/1" do
      route_for(:controller => "bikes", :action => "show", :id => 1).should == "/bikes/1"
    end
  
    it "should map { :controller => 'bikes', :action => 'edit', :id => 1 } to /bikes/1/edit" do
      route_for(:controller => "bikes", :action => "edit", :id => 1).should == "/bikes/1/edit"
    end
  
    it "should map { :controller => 'bikes', :action => 'update', :id => 1} to /bikes/1" do
      route_for(:controller => "bikes", :action => "update", :id => 1).should == "/bikes/1"
    end
  
    it "should map { :controller => 'bikes', :action => 'destroy', :id => 1} to /bikes/1" do
      route_for(:controller => "bikes", :action => "destroy", :id => 1).should == "/bikes/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'bikes', action => 'index' } from GET /bikes" do
      params_from(:get, "/bikes").should == {:controller => "bikes", :action => "index"}
    end
  
    it "should generate params { :controller => 'bikes', action => 'new' } from GET /bikes/new" do
      params_from(:get, "/bikes/new").should == {:controller => "bikes", :action => "new"}
    end
  
    it "should generate params { :controller => 'bikes', action => 'create' } from POST /bikes" do
      params_from(:post, "/bikes").should == {:controller => "bikes", :action => "create"}
    end
  
    it "should generate params { :controller => 'bikes', action => 'show', id => '1' } from GET /bikes/1" do
      params_from(:get, "/bikes/1").should == {:controller => "bikes", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'bikes', action => 'edit', id => '1' } from GET /bikes/1;edit" do
      params_from(:get, "/bikes/1/edit").should == {:controller => "bikes", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'bikes', action => 'update', id => '1' } from PUT /bikes/1" do
      params_from(:put, "/bikes/1").should == {:controller => "bikes", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'bikes', action => 'destroy', id => '1' } from DELETE /bikes/1" do
      params_from(:delete, "/bikes/1").should == {:controller => "bikes", :action => "destroy", :id => "1"}
    end
  end
end