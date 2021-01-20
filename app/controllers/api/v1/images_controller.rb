class Api::V1::ImagesController < ApplicationController
  def background
    render json: ImageSerializer.new(image)
  end

  private

  def image
    @image ||= ImageFacade.background(params[:location])
  end
end
