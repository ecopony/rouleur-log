require File.dirname(__FILE__) + '/../spec_helper'

describe RoutesController do
  
  before(:each) do
    controller.stub!(:authenticated?).and_return(true)
  end
  
  describe "handling GET /routes" do

    before(:each) do
      
      @route = mock_model(Route)
      Route.stub!(:find).and_return([@route])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all routes" do
      Route.should_receive(:find).and_return([@route])
      do_get
    end
  
    it "should assign the found routes for the view" do
      do_get
      assigns[:routes].should == [@route]
    end
  end

  describe "handling GET /routes.xml" do

    before(:each) do
      @route = mock_model(Route, :to_xml => "XML")
      Route.stub!(:find).and_return(@route)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all routes" do
      Route.should_receive(:find).and_return([@route])
      do_get
    end
  
    it "should render the found routes as xml" do
      @route.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /routes/1" do

    before(:each) do
      @route = mock_model(Route)
      Route.stub!(:find).and_return(@route)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the route requested" do
      Route.should_receive(:find).with("1").and_return(@route)
      do_get
    end
  
    it "should assign the found route for the view" do
      do_get
      assigns[:route].should equal(@route)
    end
  end

  describe "handling GET /routes/1.xml" do

    before(:each) do
      @route = mock_model(Route, :to_xml => "XML")
      Route.stub!(:find).and_return(@route)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the route requested" do
      Route.should_receive(:find).with("1").and_return(@route)
      do_get
    end
  
    it "should render the found route as xml" do
      @route.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /routes/new" do

    before(:each) do
      @route = mock_model(Route)
      Route.stub!(:new).and_return(@route)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new route" do
      Route.should_receive(:new).and_return(@route)
      do_get
    end
  
    it "should not save the new route" do
      @route.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new route for the view" do
      do_get
      assigns[:route].should equal(@route)
    end
  end

  describe "handling GET /routes/1/edit" do

    before(:each) do
      @route = mock_model(Route)
      Route.stub!(:find).and_return(@route)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the route requested" do
      Route.should_receive(:find).and_return(@route)
      do_get
    end
  
    it "should assign the found Route for the view" do
      do_get
      assigns[:route].should equal(@route)
    end
  end

  describe "handling POST /routes" do

    before(:each) do
      @route = mock_model(Route, :to_param => "1")
      @route.stub!(:user_id=)
      Route.stub!(:new).and_return(@route)
    end
    
    describe "with successful save" do
  
      def do_post
        @route.should_receive(:save).and_return(true)
        post :create, :route => {}
      end
  
      it "should create a new route" do
        Route.should_receive(:new).with({}).and_return(@route)
        do_post
      end

      it "should redirect to the new route" do
        do_post
        response.should redirect_to(route_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @route.should_receive(:save).and_return(false)
        post :create, :route => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /routes/1" do

    before(:each) do
      @route = mock_model(Route, :to_param => "1")
      Route.stub!(:find).and_return(@route)
    end
    
    describe "with successful update" do

      def do_put
        @route.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the route requested" do
        Route.should_receive(:find).with("1").and_return(@route)
        do_put
      end

      it "should update the found route" do
        do_put
        assigns(:route).should equal(@route)
      end

      it "should assign the found route for the view" do
        do_put
        assigns(:route).should equal(@route)
      end

      it "should redirect to the route" do
        do_put
        response.should redirect_to(route_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @route.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /routes/1" do

    before(:each) do
      @route = mock_model(Route, :destroy => true)
      Route.stub!(:find).and_return(@route)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the route requested" do
      Route.should_receive(:find).with("1").and_return(@route)
      do_delete
    end
  
    it "should call destroy on the found route" do
      @route.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the routes list" do
      do_delete
      response.should redirect_to(routes_url)
    end
  end
end