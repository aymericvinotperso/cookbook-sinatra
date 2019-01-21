require "open-uri"
require "nokogiri"
require_relative 'recipe'

class Parser
  attr_reader :url, :top_recipes
  def initialize(keyword)
    @url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{keyword}&st=1"
    @top_recipes = []
    html_content = open(@url).read
    doc = Nokogiri::HTML(html_content)
    doc.search('.m_titre_resultat a').each do |element|
      @top_recipes << import_recipe(element.text.strip, "http://www.letscookfrench.com#{element.attribute('href').value}")
      # @top_recipes[element.text.strip] = "http://www.letscookfrench.com#{element.attribute('href').value}"
    end
  end

  private

  def import_recipe(keyword, url)
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    content_string = ""
    # doc.search('.m_content_recette_main > :not(script)').each { |element| content_string += element.text.strip }
    doc.search('.m_content_recette_todo').each { |element| content_string += element.text.strip }
    prep_time = doc.search('.preptime').text.to_i
    difficulty = doc.search('.m_content_recette_breadcrumb').text.split("-")[1].gsub("\r\n", "").strip
    Recipe.new(keyword, content_string, prep_time, difficulty)
  end
end


# s = Parser.new("mint")
# p s
