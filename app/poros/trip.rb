class Trip
  attr_reader :formatted_time

  def initialize(trip_data)
    @formattedTime = trip_data[:route][:formattedTime].split(':')
  end
end
