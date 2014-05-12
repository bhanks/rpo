class DashboardController < ApplicationController
  def products
    @products = Product.all
  end
end
