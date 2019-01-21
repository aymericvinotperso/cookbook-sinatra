class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      if recipe.done == true
        mark = "[X]"
      else
        mark = "[ ]"
      end
      puts "#{mark} #{index + 1} - #{recipe.name} - prep time #{recipe.prep_time} min and difficulty #{recipe.difficulty}."
    end
  end

  # def display_description(recipes)
  #   recipes.each_with_index do |recipe, index|
  #     puts "#{index + 1} - #{recipe.name} - #{recipe.description} - prep time is #{recipe.prep_time} min."
  #   end
  # end

  def waiting_message
    puts "parsing..."
  end

  def display_parsed(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name}"
    end
  end

  def display_description(recipe)
    puts "#{recipe.name}: #{recipe.description}"
  end

  def ask_user_for_recipe_name
    puts 'What is the name of your recipe?'
    gets.chomp
  end

  def ask_user_for_recipe_description
    puts 'What is the description of your recipe?'
    gets.chomp
  end

  def ask_user_for_index
    puts 'On which index do you want to operate?'
    gets.chomp.to_i - 1
  end

  def ask_user_for_recipe_index
    puts 'Which recipe from lets cook do you want to add?'
    gets.chomp.to_i - 1
  end

  def ask_user_for_ingredient
    puts "What ingredient would you like a recipe for?"
    puts ">"
    gets.chomp
  end

  def error_index
    error("Va te faire foutre mauvais index")
  end

  private

  def error(msg)
    puts msg.upcase + "!!!"
  end
end
