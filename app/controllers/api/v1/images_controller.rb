class Api::V1::ImagesController < ApplicationController
  def background
    render json: ImageSerializer.new(image)
  end

  private

  def image
    @image ||= Image.new(
      ImageService.background(params[:location])
    )
  end
end
