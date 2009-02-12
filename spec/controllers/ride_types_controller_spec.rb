require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RideTypesController do

  before(:each) do
    mock_user
    controller.stub!(:authenticated?).and_return(true)
  end
  
  def mock_ride_type(stubs={})
    @mock_ride_type ||= mock_model(RideType, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all ride_types as @ride_types" do
      RideType.should_receive(:find).and_return([mock_ride_type])
      get :index
      assigns[:ride_types].should == [mock_ride_type]
    end

    describe "with mime type of xml" do
  
      it "should render all ride_types as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        RideType.should_receive(:find).and_return(ride_types = mock("Array of RideTypes"))
        ride_types.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested ride_type as @ride_type" do
      RideType.should_receive(:find).with("37").and_return(mock_ride_type)
      get :show, :id => "37"
      assigns[:ride_type].should equal(mock_ride_type)
    end
    
    describe "with mime type of xml" do

      it "should render the requested ride_type as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        RideType.should_receive(:find).with("37").and_return(mock_ride_type)
        mock_ride_type.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new ride_type as @ride_type" do
      RideType.should_receive(:new).and_return(mock_ride_type)
      get :new
      assigns[:ride_type].should equal(mock_ride_type)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested ride_type as @ride_type" do
      RideType.should_receive(:find).with("37").and_return(mock_ride_type)
      get :edit, :id => "37"
      assigns[:ride_type].should equal(mock_ride_type)
    end

  end

  describe "responding to POST create" do
    
    describe "with valid params" do
      
      before(:each) do
        @ride_type = mock_ride_type(:save => true)
        @ride_type.stub!(:user_id=)
      end
      
      it "should expose a newly created ride_type as @ride_type" do
        RideType.should_receive(:new).with({'these' => 'params'}).and_return(@ride_type)
        post :create, :ride_type => {:these => 'params'}
        assigns(:ride_type).should equal(@ride_type)
      end

      it "should redirect to the created ride_type" do
        RideType.stub!(:new).and_return(@ride_type)
        post :create, :ride_type => {}
        response.should redirect_to(ride_type_url(@ride_type))
      end
      
    end
    
    describe "with invalid params" do
      
      before(:each) do
        @ride_type = mock_ride_type(:save => false)
        @ride_type.stub!(:user_id=)
      end

      it "should expose a newly created but unsaved ride_type as @ride_type" do
        RideType.stub!(:new).with({'these' => 'params'}).and_return(@ride_type)
        post :create, :ride_type => {:these => 'params'}
        assigns(:ride_type).should equal(@ride_type)
      end

      it "should re-render the 'new' template" do
        RideType.stub!(:new).and_return(@ride_type)
        post :create, :ride_type => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested ride_type" do
        RideType.should_receive(:find).with("37").and_return(mock_ride_type)
        mock_ride_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ride_type => {:these => 'params'}
      end

      it "should expose the requested ride_type as @ride_type" do
        RideType.stub!(:find).and_return(mock_ride_type(:update_attributes => true))
        put :update, :id => "1"
        assigns(:ride_type).should equal(mock_ride_type)
      end

      it "should redirect to the ride_type" do
        RideType.stub!(:find).and_return(mock_ride_type(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(ride_type_url(mock_ride_type))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested ride_type" do
        RideType.should_receive(:find).with("37").and_return(mock_ride_type)
        mock_ride_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ride_type => {:these => 'params'}
      end

      it "should expose the ride_type as @ride_type" do
        RideType.stub!(:find).and_return(mock_ride_type(:update_attributes => false))
        put :update, :id => "1"
        assigns(:ride_type).should equal(mock_ride_type)
      end

      it "should re-render the 'edit' template" do
        RideType.stub!(:find).and_return(mock_ride_type(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested ride_type" do
      RideType.should_receive(:find).with("37").and_return(mock_ride_type)
      mock_ride_type.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the ride_types list" do
      RideType.stub!(:find).and_return(mock_ride_type(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(ride_types_url)
    end

  end

end
