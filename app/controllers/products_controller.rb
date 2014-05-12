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

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update_attributes(product_params)
    @product.save!
    redirect_to products_dashboard_index_path
  end

  protected

  def product_params
    params[:product].permit(:title, :subtitle, :description, :display_order, :image, :featured, :visible)
  end

end
