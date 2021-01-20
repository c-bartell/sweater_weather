class ImageFacade
  class << self
    def background(location_string)
      Image.new(
        ImageService.background(location_string)
      )
    end
  end
end
