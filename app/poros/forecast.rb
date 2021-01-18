class Forecast
  attr_reader :daily_weather,
              :hourly_weather

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
      temperature: @current_weather[:temperature],
      feels_like: @current_weather[:feels_like],
      humidity: @current_weather[:humidity],
      uvi: @current_weather[:uvi],
      visibility: @current_weather[:visibility],
      conditions: @current_weather[:weather][0][:description],
      icon: @current_weather[:weather][0][:icon]
    }
  end

  def format_datetime(seconds)
    Time.at(seconds).to_s
  end
end
