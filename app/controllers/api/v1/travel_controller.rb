class Api::V1::TravelController < ApplicationController
  def munchies
    start_point = GeocodeFacade.location(params[:start])
    end_point = GeocodeFacade.location(params[:end])
    binding.pry
  end
end
