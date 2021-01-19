require 'rails_helper'

describe 'Forecast Serializer' do
  it 'can serialize a forecast' do
    VCR.use_cassette('denverco_weather_request') do
      location = instance_double('Location', latitude: 39.738453, longitude: -104.984853)
      forecast = Forecast.new(
        WeatherService.weather_at_coords(location)
      )
      serialized_json = ForecastSerializer.new(forecast).serialized_json
      parsed_json = JSON.parse(serialized_json, symbolize_names: true)

      expect(parsed_json).to be_a Hash
      expect(parsed_json).to have_key :data

      data = parsed_json[:data]

      expect(data).to have_key :id
      expect(data).to have_key :type
      expect(data[:type]).to be_a String
      expect(data).to have_key :attributes
      expect(data[:attributes]).to be_a Hash

      attributes = data[:attributes]

      expect(attributes).to have_key :current_weather
      expect(attributes[:current_weather]).to be_a Hash
      expect(attributes).to have_key :daily_weather
      expect(attributes[:daily_weather]).to be_an Array
      expect(attributes).to have_key :hourly_weather
      expect(attributes[:hourly_weather]).to be_an Array

      current_weather = attributes[:current_weather]

      expect(current_weather).to have_key :datetime
      expect(current_weather[:datetime]).to be_a String
      expect(current_weather).to have_key :sunrise
      expect(current_weather[:sunrise]).to be_a String
      expect(current_weather).to have_key :sunset
      expect(current_weather[:sunset]).to be_a String
      expect(current_weather).to have_key :temperature
      expect(current_weather[:temperature]).to be_a Float
      expect(current_weather).to have_key :feels_like
      expect(current_weather[:feels_like]).to be_a Float
      expect(current_weather).to have_key :humidity
      expect(current_weather[:humidity]).to be_an Integer
      expect(current_weather).to have_key :uvi
      expect(current_weather[:uvi]).to be_a Numeric
      expect(current_weather).to have_key :visibility
      expect(current_weather[:visibility]).to be_an Integer
      expect(current_weather).to have_key :conditions
      expect(current_weather[:conditions]).to be_a String
      expect(current_weather).to have_key :icon
      expect(current_weather[:icon]).to be_a String

      daily_weather = attributes[:daily_weather]

      expect(daily_weather[0]).to have_key :date
      expect(daily_weather[0][:date]).to be_a String
      expect(daily_weather[0]).to have_key :sunrise
      expect(daily_weather[0][:sunrise]).to be_a String
      expect(daily_weather[0]).to have_key :sunset
      expect(daily_weather[0][:sunset]).to be_a String
      expect(daily_weather[0]).to have_key :max_temp
      expect(daily_weather[0][:max_temp]).to be_a Float
      expect(daily_weather[0]).to have_key :min_temp
      expect(daily_weather[0][:min_temp]).to be_a Float
      expect(daily_weather[0]).to have_key :conditions
      expect(daily_weather[0][:conditions]).to be_a String
      expect(daily_weather[0]).to have_key :icon
      expect(daily_weather[0][:icon]).to be_a String

      hourly_weather = attributes[:hourly_weather]

      expect(hourly_weather[0]).to have_key :time
      expect(hourly_weather[0][:time]).to be_a String
      expect(hourly_weather[0]).to have_key :temperature
      expect(hourly_weather[0][:temperature]).to be_a Float
      expect(hourly_weather[0]).to have_key :wind_speed
      expect(hourly_weather[0][:wind_speed]).to be_a String
      expect(hourly_weather[0]).to have_key :wind_direction
      expect(hourly_weather[0][:wind_direction]).to be_a String
      expect(hourly_weather[0]).to have_key :conditions
      expect(hourly_weather[0][:conditions]).to be_a String
      expect(hourly_weather[0]).to have_key :icon
      expect(hourly_weather[0][:icon]).to be_a String
    end
  end
end
