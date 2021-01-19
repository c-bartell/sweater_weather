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
    trip = conn.get('route') do |req|
      req.params[:from] = params[:start]
      req.params[:to] = params[:end]
    end
    binding.pry
  end
end
