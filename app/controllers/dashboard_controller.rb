class DashboardController < ApplicationController
  ACTION_TO_TYPE = {
    "foods" => "Food",
    "games" => "Game",
    "beers" => "Beer",
    "pizzas" => "Pizza"
  }
  before_filter :authenticate_user!

  def index

  end


  def posts
    @posts = Post.order("created_at ASC")
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
  def foods
    products
  end

end
