class ImageSerializer
  include FastJsonapi::ObjectSerializer
  set_type :image
  attribute :image do |object|
    {
      location: object.location,
      image_url: object.image_url,
      alt_description: object.alt_description,
      credit: object.credit
    }
  end
end
