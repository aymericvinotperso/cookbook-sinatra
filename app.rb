require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
require_relative 'cookbook'
require_relative 'parser'


configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @cookbook = Cookbook.new('recipes.csv')
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  @cookbook = Cookbook.new('recipes.csv')
  recipe = Recipe.new(params[:name], params[:description])
  @cookbook.add_recipe(recipe)
  erb :index
end

get '/destroy/:index' do
  @cookbook = Cookbook.new('recipes.csv')
  @cookbook.remove_recipe(params[:index].to_i)
  erb :index
end
