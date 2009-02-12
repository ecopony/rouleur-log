class CommutesController < ApplicationController

  def index
    @commutes = Commute.find(:all, :conditions =>"user_id = #{User.current_user.id}")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @commutes }
    end
  end

  def show
    @commute = Commute.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @commute }
    end
  end

  def new
    @commute = Commute.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @commute }
    end
  end

  def edit
    @commute = Commute.find(params[:id])
  end

  def create
    @commute = Commute.new(params[:commute])
    @commute.user_id = User.current_user.id

    respond_to do |format|
      if @commute.save
        flash[:notice] = 'Commute was successfully created.'
        format.html { redirect_to(@commute) }
        format.xml  { render :xml => @commute, :status => :created, :location => @commute }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @commute.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @commute = Commute.find(params[:id])

    respond_to do |format|
      if @commute.update_attributes(params[:commute])
        flash[:notice] = 'Commute was successfully updated.'
        format.html { redirect_to(@commute) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @commute.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @commute = Commute.find(params[:id])
    @commute.destroy

    respond_to do |format|
      format.html { redirect_to(commutes_url) }
      format.xml  { head :ok }
    end
  end
end
