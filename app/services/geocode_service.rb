class GeocodeService
  class << self
    def location_to_coords(location)
      response = conn.post('address') do |req|
        req.body = {
          location: location,
          options: options
        }.to_json
      end

      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def conn
      Faraday.new(
        url: 'https://www.mapquestapi.com/geocoding/v1',
        params: {
          key: ENV['GEOCODE_API_KEY']
        },
        headers: {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
      )
    end

    def options
      {
        thumbMaps: false,
        maxResults: 1,
        intlMode: 'AUTO'
      }
    end
  end
end
