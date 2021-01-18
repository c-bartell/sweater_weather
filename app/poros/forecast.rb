class Forecast
  attr_reader :hourly_weather

  def initialize(data)
    @current_weather = data[:current]
    @daily_weather = data[:daily][1..5]
    @hourly_weather = data[:hourly][1..8]
  end

  def current_weather
    {
      datetime: format_datetime(@current_weather[:dt]),
      sunrise: format_datetime(@current_weather[:sunrise]),
      sunset: format_datetime(@current_weather[:sunset]),
      temperature: @current_weather[:temp],
      feels_like: @current_weather[:feels_like],
      humidity: @current_weather[:humidity],
      uvi: @current_weather[:uvi],
      visibility: @current_weather[:visibility],
      conditions: @current_weather[:weather][0][:description],
      icon: @current_weather[:weather][0][:icon]
    }
  end

  def daily_weather
    @daily_weather.map do |day|
      {
        date: Time.at(day[:dt]).getlocal.strftime('%Y-%m-%d'),
        sunrise: format_datetime(day[:sunrise]),
        sunset: format_datetime(day[:sunset]),
        max_temp: day[:temp][:max],
        min_temp: day[:temp][:min],
        conditions: day[:weather][0][:description],
        icon: day[:weather][0][:icon]
      }
    end
  end

  def format_datetime(seconds)
    Time.at(seconds).getlocal.to_s
  end
end
