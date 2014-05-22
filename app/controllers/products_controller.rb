class ProductsController < ApplicationController
  layout "dashboard.html.erb"

  def index
    @products = Product.all 
  end

  def new
    @product = Product.new
    @product.prices.build
  end
  def create
    remove_featured if params[:product][:featured].to_i == 1
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_dashboard_index_path 
    else
      render action: "edit", layout: "dashboard"
    end

  end

  def edit
    @product = Product.find(params[:id])
    @product.prices.build if @product.prices.length == 0
  end

  def update
    remove_featured if params[:product][:featured].to_i == 1
    @product = Product.find(params[:id])
    @product.update_attributes(product_params)
    if @product.save
      redirect_to products_dashboard_index_path 
    else
      render action: "edit", layout: "dashboard"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "#{@product.title} successfully destroyed."
    redirect_to products_dashboard_index_path
  end

  def toggle_visible
    @product = Product.find(params[:id])
    unless @product.featured
      @product.visible = !@product.visible
      @product.save
      flash[:notice] = @product.visible ? "#{@product.title} is now publicly visible." : "#{@product.title} is no longer publicly visible."
    else
      flash[:error] = "The featured product must remain visible."
    end
    redirect_to products_dashboard_index_path
  end

  def make_featured
    @product = Product.find(params[:id])
    unless @product.featured
      if @product.visible
        remove_featured 
        @product.featured = true
        @product.save
        flash[:notice] = @product.visible ? "#{@product.title} is now featured." : "#{@product.title} is no longer featured."
      else
        flash[:error] = "The featured product must be visible."
      end
    else
      flash[:notice] = "#{@product.title} is already featured."
    end
    redirect_to products_dashboard_index_path
  end


  protected

  def product_params
    params[:product].permit(:title, :subtitle, :description, :display_order, :image, :featured, :visible, prices_attributes: [:amount, :description, :id, :_destroy])
  end

  private
  def remove_featured
    @old_featured = Product.where(featured: true).first
    if @old_featured
      @old_featured.featured = false
      @old_featured.save
    end
  end

end
