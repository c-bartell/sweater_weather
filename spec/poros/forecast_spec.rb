require 'rails_helper'

describe 'Forecast' do
  before :each do
    VCR.use_cassette('denverco_weather_request') do
      location = instance_double('Location', latitude: 39.738453, longitude: -104.984853)
      @data = WeatherService.weather_at_coords(location)
    end
  end

  it 'exists' do
    expect(Forecast.new(@data)).to be_a Forecast
  end

  it 'has attributes' do
    forecast = Forecast.new(@data)

    expect(forecast.current_weather).to be_a CurrentWeather
    expect(forecast.daily_weather).to be_an Array
    expect(forecast.daily_weather.length).to eq(5)
    expect(forecast.daily_weather.first).to be_a DailyWeather
    expect(forecast.hourly_weather).to be_an Array
    expect(forecast.hourly_weather.length).to eq(8)
    expect(forecast.hourly_weather.first).to be_an HourlyWeather
  end
end
