class Image
  attr_reader :location,
              :image_url,
              :alt_description,
              :credit

  def initialize(data)
    @location = data[:location][:title]
    @image_url = data[:urls][:full]
    @alt_description = data[:alt_description]
    @credit = credit_initialize(data)
  end

  def id; end

  def credit_initialize(data)
    {
      source: 'unsplash.com',
      author: data[:user][:username],
      author_page: data[:user][:links][:html]
    }
  end
end
