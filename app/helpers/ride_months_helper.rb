module RideMonthsHelper
  def render_dashboard_ride_months
    result = ""
    distance_for_the_year = 0
    
    @this_years_ride_months.each do |ride_month|
      distance_for_the_year = distance_for_the_year + ride_month.distance
      result << "#{Time::RFC2822_MONTH_NAME[ride_month.month-1]} #{pluralize(ride_month.distance.to_i, "miles")}"
      result << "<br/>"
    end

    result << "<br/>"
    result << pluralize(distance_for_the_year.to_i, "miles")
    result << " for the year"

    unless @this_years_ride_months.size <= 1
      average = (distance_for_the_year-@this_years_ride_months.last.distance)/(Time.now.month-1)
      pace = average * 12
      result << "<br/><br/>"
      result << "Average per month: #{average.to_i}"
      result << "<br/>"
      result << "Pace for year: #{pace.to_i}"
    end
    
    result
  end
end
