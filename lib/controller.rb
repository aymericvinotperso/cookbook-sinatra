require_relative 'recipe'
require_relative 'view'
require_relative 'services/parser'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
    display_description
  end

  def display_description
    index = @view.ask_user_for_index
    recipe = @cookbook.recipes[index]
    @view.display_description(recipe)
  end

  def create
    name = @view.ask_user_for_recipe_name
    description = @view.ask_user_for_recipe_description
    recipe = Recipe.new(name, description)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    display_recipes
    index = @view.ask_user_for_index
    if @cookbook.recipe_index_exists?(index)
      @cookbook.remove_recipe(index)
    else
      @view.error_index
    end
  end

  def lets_cook_parsing
    ingredient = @view.ask_user_for_ingredient
    @view.waiting_message
    lets_cook_parsing = Parser.new(ingredient)
    @view.display_parsed(lets_cook_parsing.top_recipes[0..4])
    index = @view.ask_user_for_recipe_index
    @cookbook.add_recipe(lets_cook_parsing.top_recipes[index])
  end

  def mark_as_done
    display_recipes
    index = @view.ask_user_for_index
    if @cookbook.recipe_index_exists?(index)
      @cookbook.mark_as_done(index)
    else
      @view.error_index
    end
  end

  private

  def display_recipes
    recipes = @cookbook.all
    @view.display(recipes)
  end
end
