class Api::V1::ImagesController < ApplicationController
  def background
    payload = {
      data: {
        id: nil,
        type: 'image',
        attributes: {
          image: {
            location: background_data[:location][:title],
            image_url: background_data[:urls][:full],
            alt_description: background_data[:alt_description],
            credit: {
              source: 'unsplash.com',
              author: background_data[:user][:username],
              author_page: background_data[:user][:links][:html]
            }
          }
        }
      }
    }

    render json: payload
  end

  private

  def background_data
    @background_data ||= ImageService.background(params[:location])
  end
end
