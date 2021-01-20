class WeatherFacade
  class << self
    def forecast(location)
      Forecast.new(
        WeatherService.weather_at_coords(location)
      )
    end
  end
end
