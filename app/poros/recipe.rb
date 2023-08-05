class Recipe
  attr_reader :id, :title, :url, :country, :image_url
  def initialize(details, search)
    @id = nil
    @title = details[:label]
    @url = details[:url]
    @country = search
    @image_url = details[:image]
  end
end