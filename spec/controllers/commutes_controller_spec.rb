require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommutesController do

  before(:each) do
    controller.stub!(:authenticated?).and_return(true)
  end
  
  def mock_commute(stubs={})
    @mock_commute ||= mock_model(Commute, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all commutes as @commutes" do
      Commute.should_receive(:find).and_return([mock_commute])
      get :index
      assigns[:commutes].should == [mock_commute]
    end

    describe "with mime type of xml" do
  
      it "should render all commutes as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Commute.should_receive(:find).and_return(commutes = mock("Array of Commutes"))
        commutes.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested commute as @commute" do
      Commute.should_receive(:find).with("37").and_return(mock_commute)
      get :show, :id => "37"
      assigns[:commute].should equal(mock_commute)
    end
    
    describe "with mime type of xml" do

      it "should render the requested commute as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Commute.should_receive(:find).with("37").and_return(mock_commute)
        mock_commute.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new commute as @commute" do
      Commute.should_receive(:new).and_return(mock_commute)
      get :new
      assigns[:commute].should equal(mock_commute)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested commute as @commute" do
      Commute.should_receive(:find).with("37").and_return(mock_commute)
      get :edit, :id => "37"
      assigns[:commute].should equal(mock_commute)
    end

  end

  describe "responding to POST create" do
    
    describe "with valid params" do
      
      before(:each) do
        @commute = mock_commute(:save => true)
        @commute.stub!(:user_id=)
      end
      
      it "should expose a newly created commute as @commute" do
        Commute.should_receive(:new).with({'these' => 'params'}).and_return(@commute)
        post :create, :commute => {:these => 'params'}
        assigns(:commute).should equal(@commute)
      end

      it "should redirect to the created commute" do
        Commute.stub!(:new).and_return(@commute)
        post :create, :commute => {}
        response.should redirect_to(commute_url(@commute))
      end
      
    end
    
    describe "with invalid params" do
      
      before(:each) do
        @commute = mock_commute(:save => false)
        @commute.stub!(:user_id=)
      end

      it "should expose a newly created but unsaved commute as @commute" do
        Commute.stub!(:new).with({'these' => 'params'}).and_return(@commute)
        post :create, :commute => {:these => 'params'}
        assigns(:commute).should equal(@commute)
      end

      it "should re-render the 'new' template" do
        Commute.stub!(:new).and_return(@commute)
        post :create, :commute => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested commute" do
        Commute.should_receive(:find).with("37").and_return(mock_commute)
        mock_commute.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :commute => {:these => 'params'}
      end

      it "should expose the requested commute as @commute" do
        Commute.stub!(:find).and_return(mock_commute(:update_attributes => true))
        put :update, :id => "1"
        assigns(:commute).should equal(mock_commute)
      end

      it "should redirect to the commute" do
        Commute.stub!(:find).and_return(mock_commute(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(commute_url(mock_commute))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested commute" do
        Commute.should_receive(:find).with("37").and_return(mock_commute)
        mock_commute.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :commute => {:these => 'params'}
      end

      it "should expose the commute as @commute" do
        Commute.stub!(:find).and_return(mock_commute(:update_attributes => false))
        put :update, :id => "1"
        assigns(:commute).should equal(mock_commute)
      end

      it "should re-render the 'edit' template" do
        Commute.stub!(:find).and_return(mock_commute(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested commute" do
      Commute.should_receive(:find).with("37").and_return(mock_commute)
      mock_commute.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the commutes list" do
      Commute.stub!(:find).and_return(mock_commute(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(commutes_url)
    end

  end

end
