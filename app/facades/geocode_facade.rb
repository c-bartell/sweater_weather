class GeocodeFacade
  class << self
    def location(location_string)
      Location.new(
        GeocodeService.location_to_coords(location_string)
      )
    end
  end
end
