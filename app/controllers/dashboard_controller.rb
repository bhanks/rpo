class DashboardController < ApplicationController
  def products
    type = ProductsController::CONTROLLER_TO_MODEL[params[:action]]
    @products = Product.where(type: type)
    render "products"
  end

  def games
    products
  end

end
