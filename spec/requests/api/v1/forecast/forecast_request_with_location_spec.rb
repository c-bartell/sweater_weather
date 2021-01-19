require 'rails_helper'

describe 'Forecast Request' do
  it 'can return forcast information for a location string' do
    VCR.use_cassette('denverco_weather_request') do
      VCR.use_cassette('denverco_coord_request') do
        location = 'denver,co'
        headers = {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
        get api_v1_forecast_path(location: location), headers: headers

        expect(response).to be_successful

        forecast_response = JSON.parse(response.body, symbolize_names: true)

        expect(forecast_response).to be_a Hash
        expect(forecast_response).to have_key :data

        data = forcast_response[:data]

        expect(data[:id]).to be nil
        expect(data[:type]).to eq('forecast')

        current_weather = data[:attributes][:current_weather]

        expect(current_weather[:datetime]).to eq '2021-01-18 09:31:02 -0700'
        expect(current_weather[:sunrise]).to eq '2021-01-18 07:17:38 -0700'
        expect(current_weather[:sunset]).to eq '2021-01-18 17:02:55 -0700'
        expect(current_weather[:temperature]).to eq 33.67
        expect(current_weather[:feels_like]).to eq 27.57
        expect(current_weather[:humidity]).to eq 57
        expect(current_weather[:uvi]).to eq 1.23
        expect(current_weather[:visibility]).to eq 10000
        expect(current_weather[:conditions]).to eq 'scattered clouds'
        expect(current_weather[:icon]).to eq '03d'

        daily_weather = data[:attributes][:daily_weather]

        expect(daily_weather.length).to eq 5
        expect(daily_weather[0][:date]).to eq '2021-01-19'
        expect(daily_weather[0][:sunrise]).to eq '2021-01-19 07:17:07 -0700'
        expect(daily_weather[0][:sunset]).to eq '2021-01-19 17:04:03 -0700'
        expect(daily_weather[0][:max_temp]).to eq 36.46
        expect(daily_weather[0][:min_temp]).to eq 28.2
        expect(daily_weather[0][:conditions]).to eq 'overcast clouds'
        expect(daily_weather[0][:icon]).to eq '04d'

        hourly_weather = data[:attributes][:hourly_weather]

        expect(daily_weather.length).to eq 5

        expect(hourly_weather[0][:time]).to eq '10:00:00'
        expect(hourly_weather[0][:temperature]).to eq 34.16
        expect(hourly_weather[0][:wind_speed]).to eq '4.81 mph'
        expect(hourly_weather[0][:wind_direction]).to eq 'from SE'
        expect(hourly_weather[0][:conditions]).to eq 'scattered clouds'
        expect(hourly_weather[0][:icon]).to eq '03d'
      end
    end
  end
end
