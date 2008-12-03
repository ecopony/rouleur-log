class BikesController < ApplicationController

  def index
    @bikes = Bike.find(:all, :conditions =>"user_id = #{@user_id}")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bikes }
    end
  end

  def show
    @bike = Bike.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bike }
      format.js
    end
  end

  def new
    @bike = Bike.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bike }
      format.js  { render :template => 'bikes/new'}
    end
  end

  def edit
    @bike = Bike.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bike }
      format.js  { render :template => 'bikes/edit'}
    end
  end

  def create
    @bike = Bike.new(params[:bike])
    @bike.user_id = @user_id

    respond_to do |format|
      if @bike.save
        flash[:notice] = 'Bike was successfully created.'
        format.html { redirect_to(@bike) }
        format.xml  { render :xml => @bike, :status => :created, :location => @bike }
        format.js { @bikes = Bike.find(:all, :conditions =>"user_id = #{@user_id}") }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bike.errors, :status => :unprocessable_entity }
        format.js { render :action => "new" }
      end
    end
  end

  def update
    @bike = Bike.find(params[:id])

    respond_to do |format|
      if @bike.update_attributes(params[:bike])
        flash[:notice] = 'Bike was successfully updated.'
        format.html { redirect_to(@bike) }
        format.xml  { head :ok }
        format.js { @bikes = Bike.find(:all, :limit => 10, :conditions =>"user_id = #{@user_id}") }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bike.errors, :status => :unprocessable_entity }
        format.js { render :action => "edit" }
      end
    end
  end

  def destroy
    @bike = Bike.find(params[:id])
    @bike.destroy

    respond_to do |format|
      format.html { redirect_to(bikes_url) }
      format.xml  { head :ok }
    end
  end
end
