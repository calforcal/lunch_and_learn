class City
  attr_reader :name

  def initialize(details)
    @name = details[:capital].first
  end
end