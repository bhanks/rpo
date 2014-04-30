class ProductsController < ApplicationController
  def index
    @products = Product.all 
  end

  def new
    @product = Product.new
  end
  def create

  end

  protected

  def product_params
    params.permit(:title, :subtitle, :description, :display_order, :image, :featured)
  end

end
