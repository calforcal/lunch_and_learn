require 'rails_helper'

RSpec.describe Country do
  it "exists" do
    attrs = {
      name: {
        common: "Michael"
      }
    }

    country = Country.new(attrs)

    expect(country.name).to be_a String
    expect(country.name).to eq("Michael")
  end
end