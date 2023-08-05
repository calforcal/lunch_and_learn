class RecipesFacade
  def recipes_index(search)
    details = service.recipes_by_country(search)
    @recipes = details[:hits].map { |recipe| Recipe.new(recipe[:recipe], search) }
  end

  def service
    RecipesService.new
  end
end