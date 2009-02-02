module RidesHelper
  def rides_calendar
    return if @year.blank? or @month.blank? or @rides.nil?
    result = ""

    next_month = (@month == 12) ? 1 : @month+1
    previous_month = (@month == 1) ? 12 : @month-1

    next_year = (@month == 12) ? @year+1 : @year
    previous_year = (@month == 1) ? @year-1 : @year

    total_distance = 0
    
    result << calendar(:year => @year, 
      :month => @month,
      :abbrev => (0..-1),
      :previous_month_text => link_to(
        "<< #{Date::MONTHNAMES[previous_month]}",
        :action => :calendar,
        :month => previous_month,
        :year => previous_year),
      :next_month_text => link_to(
        "#{Date::MONTHNAMES[next_month]} >>",
        :action => :calendar,
        :month => next_month,
        :year => next_year)
    ) do |d|

      rides_on_day = @rides.collect { |ride|
        ride if(ride.ride_on == Date.new(@year, @month, d.mday))
      }.compact

      ride_details = ""
      ride_details << "<ul class='ride-list'>" unless rides_on_day.empty?
      
      rides_on_day.each do |ride|
        total_distance += ride.distance
        
        if ride.ride_type.nil?
          ride_style = "ride-list-outside"
        else
          if ride.ride_type.is_commute
            ride_style = "ride-list-commute"
          else
            ride_style = ride.ride_type.is_inside == true ? "ride-list-inside" : "ride-list-outside"
          end
          
          
          inside_type = ride.ride_type.name
        end
        
        ride_details << "<li class='#{ride_style}'><a href='#{ride_path(ride)}'>"
        
        if ride.route.blank?
          ride_details << "#{inside_type}" unless inside_type.nil? 
        else
          ride_details << "#{ride.route.name}"
        end

        ride_details << "</a>&nbsp;#{ride.distance}"
        ride_details << "</li>"
      end
      
      ride_details << "</ul>" unless rides_on_day.empty?
      
      ["#{d.mday}<br/><br/>#{ride_details}"]
      
    end

    "Total distance for month: #{total_distance}<br/><br/>" << result
  end
end
