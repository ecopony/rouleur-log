class RidesController < ApplicationController

  def index
    @rides = Ride.paginate(
      :page => params[:page], 
      :per_page => 10, 
      :include => [:bike, :route, :ride_type], 
      :order => "ride_on DESC",
      :conditions =>"rides.user_id = #{User.current_user.id}"
    )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rides }
      format.js
    end
  end

  def show
    @ride = Ride.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ride }
      format.js
    end
  end

  def new
    @ride = Ride.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ride }
      format.js  { render :template => 'rides/new'}
    end
  end

  def edit
    @ride = Ride.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ride }
      format.js  { render :template => 'rides/edit'}
    end
  end

  def create
    @ride = Ride.new(params[:ride])
    @ride.user_id = User.current_user.id

    respond_to do |format|
      if @ride.save
        flash[:notice] = 'Ride was successfully created.'
        format.html { redirect_to(@ride) }
        format.xml  { render :xml => @ride, :status => :created, :location => @ride }
        format.js { @rides = Ride.paginate :page => params[:page], :per_page => 10, :include => [:bike, :route], :order => "ride_on DESC", :conditions =>"rides.user_id = #{@user_id}" }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ride.errors, :status => :unprocessable_entity }
        format.js { render :action => "new" }
      end
    end
  end

  def update
    @ride = Ride.find(params[:id])

    respond_to do |format|
      if @ride.update_attributes(params[:ride])
        flash[:notice] = 'Ride was successfully updated.'
        format.html { redirect_to(@ride) }
        format.xml  { head :ok }
        format.js { @rides = Ride.paginate :page => params[:page], :per_page => 10, :include => [:bike, :route], :order => "ride_on DESC", :conditions =>"rides.user_id = #{@user_id}" }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ride.errors, :status => :unprocessable_entity }
        format.js { render :action => "edit" }
      end
    end
  end

  def destroy
    @ride = Ride.find(params[:id])
    @ride.destroy

    respond_to do |format|
      format.html { redirect_to(rides_url) }
      format.xml  { head :ok }
    end
  end
  
  def calendar
    unless params[:month].blank? or params[:year].blank?
      @month = params[:month].to_i
      @year = params[:year].to_i
      start_date = Date.new(@year, @month) - 1.day
      end_date = start_date.advance(:months => 1) + 1.day
      @rides = Ride.find_all_by_user_id(User.current_user.id, :conditions => ["ride_on BETWEEN ? AND ?", start_date, end_date])
    end
  end

end
