class DashboardController < ApplicationController

  def index
    @rides = Ride.paginate(
      :page => params[:page],
      :per_page => 10,
      :include => [:bike, :route, :ride_type],
      :order => "ride_on DESC",
      :conditions =>"rides.user_id = #{User.current_user.id}")
    @bikes = Bike.find(
      :all,
      :conditions =>"user_id = #{User.current_user.id}")
    @routes = Route.find(
      :all,
      :conditions =>"user_id = #{User.current_user.id}",
      :limit => 20)

    @month_stats = Ride.month_stats
 
  end

end
