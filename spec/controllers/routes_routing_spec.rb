require File.dirname(__FILE__) + '/../spec_helper'

describe RoutesController do
  describe "route generation" do

    it "should map { :controller => 'routes', :action => 'index' } to /routes" do
      route_for(:controller => "routes", :action => "index").should == "/routes"
    end
  
    it "should map { :controller => 'routes', :action => 'new' } to /routes/new" do
      route_for(:controller => "routes", :action => "new").should == "/routes/new"
    end
  
    it "should map { :controller => 'routes', :action => 'show', :id => 1 } to /routes/1" do
      route_for(:controller => "routes", :action => "show", :id => 1).should == "/routes/1"
    end
  
    it "should map { :controller => 'routes', :action => 'edit', :id => 1 } to /routes/1/edit" do
      route_for(:controller => "routes", :action => "edit", :id => 1).should == "/routes/1/edit"
    end
  
    it "should map { :controller => 'routes', :action => 'update', :id => 1} to /routes/1" do
      route_for(:controller => "routes", :action => "update", :id => 1).should == "/routes/1"
    end
  
    it "should map { :controller => 'routes', :action => 'destroy', :id => 1} to /routes/1" do
      route_for(:controller => "routes", :action => "destroy", :id => 1).should == "/routes/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'routes', action => 'index' } from GET /routes" do
      params_from(:get, "/routes").should == {:controller => "routes", :action => "index"}
    end
  
    it "should generate params { :controller => 'routes', action => 'new' } from GET /routes/new" do
      params_from(:get, "/routes/new").should == {:controller => "routes", :action => "new"}
    end
  
    it "should generate params { :controller => 'routes', action => 'create' } from POST /routes" do
      params_from(:post, "/routes").should == {:controller => "routes", :action => "create"}
    end
  
    it "should generate params { :controller => 'routes', action => 'show', id => '1' } from GET /routes/1" do
      params_from(:get, "/routes/1").should == {:controller => "routes", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'routes', action => 'edit', id => '1' } from GET /routes/1;edit" do
      params_from(:get, "/routes/1/edit").should == {:controller => "routes", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'routes', action => 'update', id => '1' } from PUT /routes/1" do
      params_from(:put, "/routes/1").should == {:controller => "routes", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'routes', action => 'destroy', id => '1' } from DELETE /routes/1" do
      params_from(:delete, "/routes/1").should == {:controller => "routes", :action => "destroy", :id => "1"}
    end
  end
end