class Api::V1::RoadTripController < ApplicationController
  def create
    road_trip = RoadTripFacade.road_trip(params[:origin], params[:end_point])
    payload = {
      data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
          start_city: road_trip.start_city,
          end_city: road_trip.end_city,
          travel_time: road_trip.travel_time,
          weather_at_eta: road_trip.weather_at_eta
        }
      }
    }
    
    render json: payload
  end
end
