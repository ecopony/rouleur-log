class RideTypesController < ApplicationController

  def index
    @ride_types = RideType.find(:all, :conditions =>"user_id = #{@user_id}")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ride_types }
    end
  end

  def show
    @ride_type = RideType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ride_type }
    end
  end

  def new
    @ride_type = RideType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ride_type }
    end
  end

  def edit
    @ride_type = RideType.find(params[:id])
  end

  def create
    @ride_type = RideType.new(params[:ride_type])
    @ride_type.user_id = @user_id

    respond_to do |format|
      if @ride_type.save
        flash[:notice] = 'RideType was successfully created.'
        format.html { redirect_to(@ride_type) }
        format.xml  { render :xml => @ride_type, :status => :created, :location => @ride_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ride_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @ride_type = RideType.find(params[:id])

    respond_to do |format|
      if @ride_type.update_attributes(params[:ride_type])
        flash[:notice] = 'RideType was successfully updated.'
        format.html { redirect_to(@ride_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ride_type.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @ride_type = RideType.find(params[:id])
    @ride_type.destroy

    respond_to do |format|
      format.html { redirect_to(ride_types_url) }
      format.xml  { head :ok }
    end
  end
end
