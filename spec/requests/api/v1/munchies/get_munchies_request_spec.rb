require 'rails_helper'

describe 'Munchies request' do
  it 'can can retrieve food and forecast info for a destination city' do
    VCR.use_cassette('denver_to_pueblo_travel_request') do
      VCR.use_cassette('puebloco_weather_request') do
        VCR.use_cassette('puebloco_food_request') do
          start_point = 'denver,co'
          end_point = 'pueblo,co'
          food = 'chinese'
          headers = {
            "Content-Type" => 'application/json',
            "Accept" => 'application/json'
          }

          get api_v1_munchies_path(start: start_point, end: end_point, food: food), headers: headers

          expect(response).to be_successful

          data = JSON.parse(response.body, symbolize_names: true)[:data]

          expect(data[:id]).to be nil
          expect(data[:type]).to eq 'munchie'

          attributes = data[:attributes]

          expect(attributes[:destination_city]).to eq 'Pueblo, CO'
          expect(attributes[:travel_time]).to eq '1 hours 44 min'

          forecast = attributes[:forecast]

          expect(forecast[:summary]).to eq('Overcast clouds')
          expect(forecast[:temperature]).to eq('30')

          restaurant = attributes[:restaurant]

          expect(restaurant[:name]).to eq('Noodles & Company')
          expect(restaurant[:address]).to be_a String
        end
      end
    end
  end
end
