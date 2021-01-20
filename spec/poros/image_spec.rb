require 'rails_helper'

describe 'Image PORO' do
  before :each do
    VCR.use_cassette('denver_background_request') do
      location = 'denver,co'
      @data = ImageService.background(location)
    end
  end

  it 'has relevant attributes' do
    image = Image.new(@data)

    expect(image.id).to be nil
    expect(image.location).to eq @data[:location][:title]
    expect(image.image_url).to eq @data[:urls][:full]
    expect(image.alt_description).to eq @data[:alt_description]
    expect(image.credit).to eq(
      {
        source: 'unsplash.com',
        author: @data[:user][:username],
        author_page: @data[:user][:links][:html]
      }
    )
  end
end
