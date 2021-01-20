class RoadTrip
  attr_reader :start_city,
              :end_city,
              :lat_lng,
              :weather_at_eta

  def initialize(data)
    @start_city = city_string(data[:route][:locations].first)
    @end_city = city_string(data[:route][:locations].last)
    @travel_time = data[:route][:formattedTime]
    @lat_lng = data[:route][:locations].last[:displayLatLng]
    @weather_at_eta = nil
  end

  def id; end

  def city_string(location_data)
    "#{location_data[:adminArea5]}, #{location_data[:adminArea3]}"
  end

  def travel_time
    if @travel_time
      raw_time = @travel_time.split(':')
      "#{raw_time[0].to_i} hours #{raw_time[1]} min"
    else
      'Impossible route'
    end
  end

  def add_weather(data)
    @weather_at_eta = data
  end
end
