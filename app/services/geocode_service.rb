class GeocodeService
  class << self
    def location_to_coords(location)
      response = conn.post('geocoding/v1/address') do |req|
        req.body = {
          location: location,
          options: options
        }.to_json
      end

      JSON.parse(response.body, symbolize_names: true)
    end

    def trip_data(start_point, end_point)
      response = conn.get('directions/v2/route') do |req|
        req.params[:from] = start_point
        req.params[:to] = end_point
      end

      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def conn
      Faraday.new(
        url: 'https://www.mapquestapi.com',
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
