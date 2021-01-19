class Api::V1::WeatherController < ApplicationController
  def forecast
    location = GeocodeFacade.location(params[:location])
    forecast = Forecast.new(
      WeatherService.weather_at_coords(location)
    )

    render json: ForecastSerializer.new(forecast)
  end
end
