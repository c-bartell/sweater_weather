require 'rails_helper'

describe 'Road Trip POST request' do
  before :each do
    @user = User.create!(
      email: 'elfo@dreamland.com',
      password: 'i_heart_bean',
      password_confirmation: 'i_heart_bean'
    )
  end

  it 'I can get a road trip' do
    start_point = 'Denver,Co'
    end_point = 'Pueblo,Co'
    headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    post(
      api_v1_road_trip_path(
        origin: start_point, end_point: end_point, api_key: @user.api_key
      ),
      headers: headers
    )

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_data).to have_key :data
    expect(parsed_data[:data]).to be_a Hash

    road_trip_data = parsed_data[:data]

    expect(road_trip_data).to have_key :id
    expect(road_trip_data[:id]).to be nil
    expect(road_trip_data).to have_key :type
    expect(road_trip_data[:type]).to eq 'roadtrip'

    attributes = road_trip_data[:attributes]

    expect(attributes).to have_key :start_city
    expect(attributes[:start_city]).to be_a String
    expect(attributes).to have_key :end_city
    expect(attributes[:end_city]).to be_a String
    expect(attributes).to have_key :travel_time
    expect(attributes[:travel_time]).to be_a String
    expect(attributes).to have_key :weather_at_eta
    expect(attributes[:weather_at_eta]).to be_a Hash
    expect(attributes[:weather_at_eta]).to have_key :temperature
    expect(attributes[:weather_at_eta][:temperature]).to be_a Float
    expect(attributes[:weather_at_eta]).to have_key :conditions
    expect(attributes[:weather_at_eta][:conditions]).to be_a Float
  end
end
