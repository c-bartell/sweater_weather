require 'rails_helper'

describe 'Backgrounds request' do
  it 'can get a background for a location' do
    VCR.use_cassette('denver_background_request') do
      location = 'denver,co'
      headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

      get api_v1_backgrounds_path(location: location), headers: headers

      expect(response).to be_successful

      background_response = JSON.parse(response.body, symbolize_names: true)

      expect(background_response).to have_key :data
      expect(background_response[:data]).to be_a Hash

      data = background_response[:data]

      expect(data[:id]).to be nil
      expect(data[:type]).to eq 'image'

      image = data[:attributes][:image]

      expect(image[:location]).to be_a String
      expect(image[:image_url]).to be_a String

      credit = image[:credit]

      expect(credit[:source]).to be_a String
      expect(credit[:author]).to be_a String
      expect(credit[:logo]).to be_a String
    end
  end
end
