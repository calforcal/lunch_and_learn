require 'rails_helper'

RSpec.describe City do
  it "exists" do
    attrs = {
      capital: ["Abuja"]
    }

    city = City.new(attrs)

    expect(city.name).to eq("Abuja")
  end
end