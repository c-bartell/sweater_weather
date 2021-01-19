class Api::V1::TravelController < ApplicationController
  def munchies
    # start_point = GeocodeFacade.location(params[:start])
    # end_point = GeocodeFacade.location(params[:end])
    conn = Faraday.new(
      url: 'https://www.mapquestapi.com/directions/v2',
      params: {
        key: ENV['GEOCODE_API_KEY']
      },
      headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    )
    response = conn.get('route') do |req|
      req.params[:from] = params[:start]
      req.params[:to] = params[:end]
    end

    trip_data = JSON.parse(response.body, symbolize_names: true)
    raw_time = trip_data[:route][:formattedTime].split(':')
    trip_time = "#{raw_time[0].to_i} hours #{raw_time[1]} min"
    
    binding.pry
  end
end
