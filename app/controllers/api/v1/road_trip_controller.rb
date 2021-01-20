class Api::V1::RoadTripController < ApplicationController
  def create
    if params[:api_key] && User.find_by(api_key: params[:api_key])

      render json: RoadTripSerializer.new(road_trip)
    else

      render json: { errors: ['Invalid API key'] }, status: 401
    end
  end

  private

  def road_trip
    @road_trip ||= RoadTripFacade.road_trip(params[:origin], params[:end_point])
  end
end
