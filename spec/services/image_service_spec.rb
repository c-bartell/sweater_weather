require 'rails_helper'

describe 'Image Service' do
  it 'can get an image' do
    VCR.use_cassette('denver_background_request') do
      location = 'denver,co'
      background_data = ImageService.background(location)

      expect(background_data).to be_a Hash
      expect(background_data).to have_key :location
      expect(background_data[:location]).to be_a Hash
      expect(background_data[:location]).to have_key :title
      expect(background_data[:location][:title]).to be_a String
      expect(background_data).to have_key :urls
      expect(background_data[:urls]).to be_a Hash
      expect(background_data[:urls]).to have_key :full
      expect(background_data[:urls][:full]).to be_a String
      expect(background_data).to have_key :alt_description
      expect(background_data[:alt_description]).to be_a String
      expect(background_data).to have_key :user
      expect(background_data[:user]).to be_a Hash
      expect(background_data[:user]).to have_key :username
      expect(background_data[:user][:username]).to be_a String
      expect(background_data[:user]).to have_key :links
      expect(background_data[:user][:links]).to be_a Hash
      expect(background_data[:user][:links]).to have_key :html
      expect(background_data[:user][:links][:html]).to be_a String
    end
  end
end
