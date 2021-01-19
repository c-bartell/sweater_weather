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
      req.params[:content_filter]
      req.params[:query]
    end

    background_data = JSON.parse(response.body, symbolize_names: true)
    binding.pry
  end
end
