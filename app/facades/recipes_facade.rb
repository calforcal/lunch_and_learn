class RecipesFacade
  def recipes_index(search)
    if search == ''
      countries = CountriesFacade.new.countries_index
      search = countries.sample.name
      details = service.recipes_by_country(search)
      @recipes = if details[:hits].empty? then [] else details[:hits].map { |recipe| Recipe.new(recipe[:recipe], search) } end
    else
      details = service.recipes_by_country(search)
      @recipes = if details[:hits].empty? then [] else details[:hits].map { |recipe| Recipe.new(recipe[:recipe], search) } end
    end
  end

  def service
    RecipesService.new
  end
end