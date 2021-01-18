require 'rails_helper'

describe 'GeocodeService' do
  it 'can get coordinates from a location string' do
    location = 'denver,co'
    response = GeocodeService.location_to_coords(location)

    expect(response).to be_a Hash
    expect(response).to have_key :info
    expect(response).to have_key :options
    expect(response).to have_key :results

    info = response[:info]

    expect(info).to be_a Hash
    expect(info).to have_key :statuscode
    expect(info[:statuscode]).to be_an Integer
    expect(info[:statuscode]).to eq(0)
    expect(info).to have_key :messages
    expect(info[:messages]).to be_an Array
    expect(info[:messages]).to be_empty

    options = response[:options]

    expect(options).to be_a Hash
    expect(options).to_not be_empty

    results = response[:results]

    expect(results).to be_an Array
    expect(results.length).to eq(1)

    location_results = results.first

    expect(location_results).to be a Hash
    expect(location_results).to have_key :providedLocation
    expect(location_results[:providedLocation]).to be_a Hash

    expect(location_results[:providedLocation]).to have_key :street
    expect(location_results[:providedLocation][:street]).to be_a String
    expect(location_results[:providedLocation][:street]).to eq(location)

    expect(location_results[:providedLocation]).to have_key :locations
    expect(location_results[:providedLocation][:locations]).to be_an Array
    expect(location_results[:providedLocation][:locations]).to_not be_empty

    location_data = location_results[:providedLocation][:locations].first

    expect(location_data).to be_a Hash
    expect(location_data).to have_key :latLng

    geocoodes = location_data[:latLng]

    expect(geocodes).to be_a Hash
    expect(geocoodes).to have_key :lat
    expect(geocoodes[:lat]).to be_a Float
    expect(geocoodes[:lat]).to eq(39.738453)
    expect(geocoodes).to have_key :lng
    expect(geocoodes[:lng]).to be_a Float
    expect(geocoodes[:lng]).to eq(-104.984853)
  end
end
