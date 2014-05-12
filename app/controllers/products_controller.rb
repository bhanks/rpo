class ProductsController < ApplicationController
  layout "dashboard.html.erb"

  def index
    @products = Product.all 
  end

  def new
    @product = Product.new
  end
  def create
    @product = Product.new(product_params)
    redirect_to products_path if @product.save

  end

  protected

  def product_params
    params.permit(:title, :subtitle, :description, :display_order, :image, :featured)
  end

end
