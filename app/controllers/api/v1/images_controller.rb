class Api::V1::ImagesController < ApplicationController
  def background
    conn = Faraday.new(
      url: 'https://api.unsplash.com',
      headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Accept-Version' => 'v1',
        'Authorization' => "Client-ID #{ENV['UNSPLASH_KEY']}"
      }
    )

    response = conn.get('photos/random') do |req|
      req.params[:content_filter] = 'high'
      req.params[:query] = params[:location]
    end

    background_data = JSON.parse(response.body, symbolize_names: true)

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
    # binding.pry
    render json: payload
  end
end
