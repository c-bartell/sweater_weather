class Api::V1::RoadTripController < ApplicationController
  def create

    render json: RoadTripSerializer.new(road_trip)
  end

  private

  def road_trip
    @road_trip ||= RoadTripFacade.road_trip(params[:origin], params[:end_point])
  end
end
