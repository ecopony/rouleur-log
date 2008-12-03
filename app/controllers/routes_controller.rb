class RoutesController < ApplicationController

  def index
    @routes = Route.find(:all, :conditions =>"user_id = #{@user_id}")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @routes }
    end
  end

  def show
    @route = Route.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @route }
      format.js
    end
  end

  def new
    @route = Route.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @route }
      format.js  { render :template => 'routes/new'}
    end
  end

  def edit
    @route = Route.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @route }
      format.js  { render :template => 'routes/edit'}
    end
  end

  def create
    @route = Route.new(params[:route])
    @route.user_id = @user_id

    respond_to do |format|
      if @route.save
        flash[:notice] = 'Route was successfully created.'
        format.html { redirect_to(@route) }
        format.xml  { render :xml => @route, :status => :created, :location => @route }
        format.js { @routes = Route.find(:all, :limit => 20, :conditions =>"user_id = #{@user_id}", :conditions =>"user_id = #{@user_id}") }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @route.errors, :status => :unprocessable_entity }
        format.js { render :action => "new" }
      end
    end
  end

  def update
    @route = Route.find(params[:id])

    respond_to do |format|
      if @route.update_attributes(params[:route])
        flash[:notice] = 'Route was successfully updated.'
        format.html { redirect_to(@route) }
        format.xml  { head :ok }
        format.js { @routes = Route.find(:all, :limit => 20, :conditions =>"user_id = #{@user_id}", :conditions =>"user_id = #{@user_id}") }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @route.errors, :status => :unprocessable_entity }
        format.js { render :action => "edit" }
      end
    end
  end

  def destroy
    @route = Route.find(params[:id])
    @route.destroy

    respond_to do |format|
      format.html { redirect_to(routes_url) }
      format.xml  { head :ok }
    end
  end
end
