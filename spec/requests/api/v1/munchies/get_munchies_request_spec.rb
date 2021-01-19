require 'rails_helper'

describe 'Munchies request' do
  it 'can can retrieve food and forecast info for a destination city' do
    VCR.use_cassette('puebloco_coord_request') do
      VCR.use_cassette('denverco_coord_request') do
        start_point = 'denver,co'
        end_point = 'pueblo,co'
        food = 'chinese'
        headers = {
          "Content-Type" => 'application/json',
          "Accept" => 'application/json'
        }

        get api_v1_munchies_path(start: start_point, end: end_point, food: food), headers: headers

        expect(response).to be_successful

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:id]).to be nil
        expect(data[:type]).to eq 'munchie'

        attributes = data[:attributes]

        expect(attributes[:destination_city]).to eq 'Pueblo, CO'
        expect(attributes[:travel_time]).to eq '1 hours 48 min'

        forecast = attributes[:forecast]

        expect(forecast[:summary]).to be_a String
        expect(forecast[:temperature]).to be_a String

        restaurant = attributes[:restaurant]

        expect(restaurant[:name]).to be_a String
        expect(restaurant[:address]).to be_a String
      end
    end
  end
end
