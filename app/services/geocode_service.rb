class GeocodeService
  class << self
    def location_to_coords(location)
      conn = Faraday.new(
        url: 'https://www.mapquestapi.com/geocoding/v1',
        params: {
          key: ENV['GEOCODE_API_KEY']
        },
        headers: {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
      )
      response = conn.post('address') do |req|
        req.body = {
          location: location,
          options: {
            thumbMaps: false,
            maxResults: 1,
            intlMode: "AUTO"
          }
        }.to_json
      end

      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
