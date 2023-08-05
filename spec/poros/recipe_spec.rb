require 'rails_helper'

RSpec.describe Recipe do
  it "exists" do
    attrs = {
      label: "Fun Recipe",
      url: "fun url path",
      image: "image path"
    }

    recipe = Recipe.new(attrs, "thailand")

    expect(recipe.id).to eq(nil)
    expect(recipe.title).to eq(attrs[:label])
    expect(recipe.url).to eq(attrs[:url])
    expect(recipe.country).to eq('thailand')
    expect(recipe.image_url).to eq(attrs[:image])
  end
end