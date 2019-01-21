require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :recipes
  def initialize(csv_file_path)
    @file_path = csv_file_path
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end

  def recipe_index_exists?(recipe_index)
    @recipes[recipe_index].nil? ? false : true
  end

  def mark_as_done(recipe_index)
    @recipes[recipe_index].done = true
  end

  private

  def load_csv
    CSV.foreach(@file_path) do |row|
      @recipes << Recipe.new(row[0], row[1])
    end
  end

  def update_csv
    CSV.open(@file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty]
      end
    end
  end
end
