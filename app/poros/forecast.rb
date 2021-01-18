class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @current_weather = data[:current]
    @daily_weather = data[:daily][1..5]
    @hourly_weather = data[:hourly][1..8]
  end
end
