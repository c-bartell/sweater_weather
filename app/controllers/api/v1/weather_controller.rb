class Api::V1::WeatherController < ApplicationController
  def forecast
    render json: ForecastSerializer.new(forecast_obj)
  end

  private

  def location
    @location ||= GeocodeFacade.location(params[:location])
  end

  def forecast_obj
    @forecast_obj ||= WeatherFacade.forecast(location)
  end
end
