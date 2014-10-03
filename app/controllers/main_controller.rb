class MainController < ApplicationController
  def index
    @news = Post.limit(3).order("created_at DESC")
    @featured_game = Game.where(featured:true).first
    @featured_pizza = Pizza.where(featured:true).first
    @featured_beer = Beer.where(featured:true).first
  end
end
