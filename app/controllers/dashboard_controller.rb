


class DashboardController < ApplicationController

  def index
    @rides = Ride.paginate(
      :page => params[:page],
      :per_page => 10,
      :include => [:bike, :route, :ride_type],
      :order => "ride_on DESC",
      :conditions =>"rides.user_id = #{@user_id}")
    @bikes = Bike.find(
      :all,
      :conditions =>"user_id = #{@user_id}")
    @routes = Route.find(
      :all,
      :conditions =>"user_id = #{@user_id}",
      :limit => 20)
  end

end
