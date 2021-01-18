require 'rails_helper'

describe 'Forecast Request' do
  xit 'can return forcast information for a location string' do
    location = 'denver,co'
    headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
    get api_v1_forecast_path(location: location), headers: headers

    expect(response).to be_successful

    forecast_response = JSON.parse(response.body symbolize_names: true)

    expect(forecast_response).to be_a Hash
    expect(forecast_response).to have_key :data

    data = forcast_response[:data]
    # Decide how you should test this after writing poros, facades, serializers
    # etc. Do you need key and type checks if they're happening in the
    # serializers, or do you just need to test values?
    expect(data).to be_a Hash
    expect(data[:id]).to be nil
    expect(data[:type]).to eq('forcast')
  end
end
