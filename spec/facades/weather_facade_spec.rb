require 'rails_helper'

describe 'Weather Facade' do
  it 'Can create a forecast from a location object' do
    VCR.use_cassette('denverco_weather_request') do
      location = instance_double('Location', latitude: 39.738453, longitude: -104.984853)

      expect(WeatherFacade.forecast(location)).to be_a Forecast
    end
  end
end
