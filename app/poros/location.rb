class Location
  attr_reader :latitude,
              :longitude

  def initialize(data)
    if data[:results]
      @latitude = data[:results][0][:locations][0][:latLng][:lat]
      @longitude = data[:results][0][:locations][0][:latLng][:lng]
    else
      @latitude = data[:lat]
      @longitude = data[:lng]
    end
  end
end
