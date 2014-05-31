class DashboardController < ApplicationController
  ACTION_TO_TYPE = {
    "games" => "Game",
    "beers" => "Beer",
    "pizzas" => "Pizza"
  }


  def index

  end

  def products
    @type = ACTION_TO_TYPE[params[:action]]
    @products = Product.where(type: @type)
    render "products"
  end

  def games
    products
  end

  def beers
    products
  end

  def pizzas
    products
  end

end
