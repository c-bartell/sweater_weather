class WeatherService
  class << self
    def weather_at_coords(latitude, longitude)
      conn = Faraday.new(
        url: 'https://api.openweathermap.org/data/2.5',
        params: {
          appid: ENV['WEATHER_API_KEY'],
          exclude: 'minutely,alerts',
          units: 'imperial'
        },
        headers: {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
      )
      response = conn.get('onecall') do |req|
        req.params[:lat] = latitude
        req.params[:lon] = longitude
      end

      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
