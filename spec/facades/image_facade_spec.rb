require 'rails_helper'

describe 'Image Facade' do
  it 'it can create an image' do
    VCR.use_cassette('denver_background_request') do
      location = 'denver,co'
      background_data = ImageService.background(location)

      expect(ImageFacade.background(location)).to be_an Image
    end
  end
end
