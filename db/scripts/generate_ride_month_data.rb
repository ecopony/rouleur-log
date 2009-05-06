puts "Generating ride-month data"

Ride.all.each do |ride|
  puts "Generating ride month data for ride with id: #{ride.id}"

  ride_month = RideMonth.find_or_initialize_by_month_and_year_and_user_id(
    ride.ride_on.month,
    ride.ride_on.year,
    ride.user_id
  )

  ride_month.ride_count = ride_month.ride_count.nil? ? 1 : (ride_month.ride_count + 1)
  ride_month.distance = ride_month.distance.nil? ? ride.distance : (ride_month.distance + ride.distance)
  ride_month.save
end