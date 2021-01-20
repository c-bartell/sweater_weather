class ImageService
  class << self
    def background(location_string)
      conn = Faraday.new(
        url: 'https://api.unsplash.com',
        headers: {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json',
          'Accept-Version' => 'v1',
          'Authorization' => "Client-ID #{ENV['UNSPLASH_KEY']}"
        }
      )

      response = conn.get('photos/random') do |req|
        req.params[:content_filter] = 'high'
        req.params[:query] = location_string
      end

      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
