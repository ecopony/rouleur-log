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

    @this_years_ride_months = RideMonth.find(
      :all,
      :conditions => ["year = ? and user_id = ?", Time.new.year, User.current_user.id],
      :order => "month ASC"
    )
    
    @month_stats = Ride.month_stats # Debt: Utilize ride months?
  end

end
