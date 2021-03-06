require 'rails_helper'

describe 'WeatherService' do
  it 'can fetch weather data from geocoords' do
    VCR.use_cassette('denverco_weather_request') do
      location = instance_double('Location', latitude: 39.738453, longitude: -104.984853)
      response = WeatherService.weather_at_coords(location)

      expect(response).to be_a Hash
      expect(response).to have_key :lat
      expect(response[:lat]).to be_a Float
      expect(response).to have_key :lon
      expect(response[:lon]).to be_a Float
      expect(response).to have_key :timezone
      expect(response[:timezone]).to be_a String
      expect(response).to have_key :timezone_offset
      expect(response[:timezone_offset]).to be_an Integer
      expect(response).to have_key :current
      expect(response).to have_key :hourly
      expect(response).to have_key :daily
      expect(response).to_not have_key :minutely
      expect(response).to_not have_key :alerts

      current = response[:current]
      hourly = response[:hourly]
      daily = response[:daily]

      expect(current).to be_a Hash
      expect(current).to have_key :dt
      expect(current[:dt]).to be_an Integer
      expect(current).to have_key :sunrise
      expect(current[:sunrise]).to be_an Integer
      expect(current).to have_key :sunset
      expect(current[:sunset]).to be_an Integer
      expect(current).to have_key :temp
      expect(current[:temp]).to be_a Float
      expect(current).to have_key :feels_like
      expect(current[:feels_like]).to be_a Float
      expect(current).to have_key :pressure
      expect(current[:pressure]).to be_an Integer
      expect(current).to have_key :humidity
      expect(current[:humidity]).to be_a Numeric
      expect(current).to have_key :dew_point
      expect(current[:dew_point]).to be_a Float
      expect(current).to have_key :uvi
      expect(current[:uvi]).to be_a Numeric
      expect(current).to have_key :clouds
      expect(current[:clouds]).to be_an Integer
      expect(current).to have_key :visibility
      expect(current[:visibility]).to be_a Numeric
      expect(current).to have_key :wind_speed
      expect(current[:wind_speed]).to be_a Float
      expect(current).to have_key :wind_deg
      expect(current[:wind_deg]).to be_an Integer
      expect(current).to have_key :wind_gust
      expect(current[:wind_gust]).to be_a Float
      expect(current).to have_key :weather
      expect(current[:weather]).to be_an Array
      expect(current[:weather].first).to have_key :id
      expect(current[:weather].first[:id]).to be_an Integer
      expect(current[:weather].first).to have_key :main
      expect(current[:weather].first[:main]).to be_a String
      expect(current[:weather].first).to have_key :description
      expect(current[:weather].first[:description]).to be_a String
      expect(current[:weather].first).to have_key :icon
      expect(current[:weather].first[:icon]).to be_a String

      expect(hourly).to be_an Array

      hour = hourly.first

      expect(hour).to be_a Hash
      expect(hour).to have_key :dt
      expect(hour[:dt]).to be_an Integer
      expect(hour).to have_key :temp
      expect(hour[:temp]).to be_a Float
      expect(hour).to have_key :feels_like
      expect(hour[:feels_like]).to be_a Float
      expect(hour).to have_key :pressure
      expect(hour[:pressure]).to be_an Integer
      expect(hour).to have_key :humidity
      expect(hour[:humidity]).to be_a Numeric
      expect(hour).to have_key :dew_point
      expect(hour[:dew_point]).to be_a Float
      expect(hour).to have_key :uvi
      expect(hour[:uvi]).to be_a Numeric
      expect(hour).to have_key :clouds
      expect(hour[:clouds]).to be_an Integer
      expect(hour).to have_key :visibility
      expect(hour[:visibility]).to be_a Numeric
      expect(hour).to have_key :wind_speed
      expect(hour[:wind_speed]).to be_a Float
      expect(hour).to have_key :wind_deg
      expect(hour[:wind_deg]).to be_an Integer
      expect(hour[:weather]).to be_an Array
      expect(hour[:weather].first).to have_key :id
      expect(hour[:weather].first[:id]).to be_an Integer
      expect(hour[:weather].first).to have_key :main
      expect(hour[:weather].first[:main]).to be_a String
      expect(hour[:weather].first).to have_key :description
      expect(hour[:weather].first[:description]).to be_a String
      expect(hour[:weather].first).to have_key :icon
      expect(hour[:weather].first[:icon]).to be_a String
      expect(hour).to have_key :pop
      expect(hour[:pop]).to be_a Numeric

      expect(daily).to be_an Array

      day = daily.first

      expect(day).to be_a Hash
      expect(day).to have_key :dt
      expect(day[:dt]).to be_an Integer
      expect(day).to have_key :sunrise
      expect(day[:sunrise]).to be_an Integer
      expect(day).to have_key :sunset
      expect(day[:sunset]).to be_an Integer
      expect(day).to have_key :temp
      expect(day[:temp]).to be_a Hash
      expect(day[:temp]).to have_key :day
      expect(day[:temp][:day]).to be_a Float
      expect(day[:temp]).to have_key :min
      expect(day[:temp][:min]).to be_a Float
      expect(day[:temp]).to have_key :max
      expect(day[:temp][:max]).to be_a Float
      expect(day[:temp]).to have_key :night
      expect(day[:temp][:night]).to be_a Float
      expect(day[:temp]).to have_key :eve
      expect(day[:temp][:eve]).to be_a Float
      expect(day[:temp]).to have_key :morn
      expect(day[:temp][:morn]).to be_a Float
      expect(day).to have_key :feels_like
      expect(day[:feels_like]).to be_a Hash
      expect(day[:feels_like]).to have_key :day
      expect(day[:feels_like][:day]).to be_a Float
      expect(day[:feels_like]).to have_key :night
      expect(day[:feels_like][:night]).to be_a Float
      expect(day[:feels_like]).to have_key :eve
      expect(day[:feels_like][:eve]).to be_a Float
      expect(day[:feels_like]).to have_key :morn
      expect(day[:feels_like][:morn]).to be_a Float
      expect(day).to have_key :pressure
      expect(day[:pressure]).to be_an Integer
      expect(day).to have_key :humidity
      expect(day[:humidity]).to be_a Numeric
      expect(day).to have_key :dew_point
      expect(day[:dew_point]).to be_a Float
      expect(day).to have_key :wind_speed
      expect(day[:wind_speed]).to be_a Float
      expect(day).to have_key :wind_deg
      expect(day[:wind_deg]).to be_an Integer
      expect(day[:weather]).to be_an Array
      expect(day[:weather].first).to have_key :id
      expect(day[:weather].first[:id]).to be_an Integer
      expect(day[:weather].first).to have_key :main
      expect(day[:weather].first[:main]).to be_a String
      expect(day[:weather].first).to have_key :description
      expect(day[:weather].first[:description]).to be_a String
      expect(day[:weather].first).to have_key :icon
      expect(day[:weather].first[:icon]).to be_a String
      expect(day).to have_key :clouds
      expect(day[:clouds]).to be_an Integer
      expect(day).to have_key :pop
      expect(day[:pop]).to be_a Numeric
      expect(day).to have_key :uvi
      expect(day[:uvi]).to be_a Numeric
    end
  end
end
