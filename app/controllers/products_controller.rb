class ProductsController < ApplicationController
  layout "dashboard.html.erb"
  # http://stackoverflow.com/questions/3025784/rails-layouts-per-action

  before_filter :set_type
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    #@products = Product.where(type:@type)
    @products = Product.where(type:@type).order(:display_order).group_by(&:category)
    @food = Product.where(type:"Food").order(:display_order).group_by(&:category) if @type == "Pizza"
    @const = @type.constantize
    @featured = Product.where(type:@type, featured:true).first
    render layout:"application"
  end

  def new
    #type = Product::CONTROLLER_TO_TYPE[params[:controller]]
    @product = @type.constantize.new
    @product.prices.build
  end

  def create
    remove_featured if params[@type.downcase.to_sym][:featured].to_i == 1
    @product = @type.constantize.new(product_params)
    if @product.save
      if params[@type.downcase.to_sym][:image]
        img = ::Magick::Image::read(@product.image).first
        width = img.columns
        height = img.rows
        if(height < 250 || width < 250)
          @product.remove_image!
          @product.save!
          @product.errors.add :image, "must be at least 250 x 250"
          render action: "new", :layout => "dashboard"
        else
          redirect_to @url_helper.send("#{@type.downcase.pluralize.to_sym}_dashboard_index_path") 
        end
      else
        redirect_to @url_helper.send("#{@type.downcase.pluralize.to_sym}_dashboard_index_path") 
      end
    else
      render action: "edit", layout: "dashboard"
    end

  end

  def edit
    @product = Product.find(params[:id])
    @product.prices.build if @product.prices.length == 0
  end

  def update
    remove_featured if params[@type.downcase.to_sym][:featured].to_i == 1
    @product = Product.find(params[:id])
    @product.update_attributes(product_params)
    if @product.save
      if params[@type.downcase.to_sym][:image]
        blob = open(@product.image.url)
        #img = ::Magick::Image::from_blob(blob.read).first
        #width = img.columns
        #height = img.rows
        width = 251
        height = 251
        if(height < 250 || width < 250)
          @product.errors.add :image, "must be at least 250 x 250"
          render action: "edit", :layout => "dashboard"
        else
        debugger
          @product.image.recreate_versions!
          redirect_to @url_helper.send("#{@type.downcase.pluralize.to_sym}_dashboard_index_path") 
        end
      else
        redirect_to @url_helper.send("#{@type.downcase.pluralize.to_sym}_dashboard_index_path") 
      end
    else
      render action: "edit", layout: "dashboard"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "#{@product.title} successfully destroyed." unless @product.errors
    flash[:error] = @product.errors.messages.values.flatten.first
    redirect_to @url_helper.send("#{@type.pluralize.downcase.to_sym}_dashboard_index_path")
  end

  def toggle_visible
    @product = Product.find(params[:id])
    unless @product.featured
      @product.visible = !@product.visible
      @product.save
      if @product.save
        flash[:notice] = @product.visible ? "#{@product.title} is now publicly visible." : "#{@product.title} is no longer publicly visible."
      end 
    else
      flash[:error] = "The featured product must remain visible."
    end
    redirect_to @url_helper.send("#{@type.downcase.pluralize}_dashboard_index_path")
  end

  def make_featured
    @product = Product.find(params[:id])
    unless @product.featured
      if @product.visible
        remove_featured 
        @product.featured = true
        @product.save
        if @product.save
          flash[:notice] = @product.visible ? "#{@product.title} is now featured." : "#{@product.title} is no longer featured."
        end
      else
        flash[:error] = "The featured product must be visible."
      end
    else
      flash[:notice] = "#{@product.title} is already featured."
    end
    redirect_to @url_helper.send("#{@type.downcase.pluralize}_dashboard_index_path")
  end

  def display_order
    @products = Product.where(type:@type).order(:display_order).group_by(&:category)
  end

  def update_display_order
    params[:product].each_pair do |id, value|
      product = Product.find(id) 
      product.display_order = value    
      product.save!             
    end
    redirect_to dashboard_index_path, notice: "Lineup order for #{@type.pluralize} was successfully updated."
  end

  def crop
    @product = Product.find(params[:id])
  end

  def make_crop
    @product = Product.find(params[:id])
    @product.crop_x = params[:crop][:x1]
    @product.crop_y = params[:crop][:y1]
    @product.crop_w = params[:crop][:w]
    @product.crop_h = params[:crop][:h]
    if @product.save
      #@product.image.recreate_versions!
      flash[:notice] = "Crop successful."
      redirect_to @url_helper.send("#{@type.pluralize.downcase.to_sym}_dashboard_index_path")
    else
      redirect_to @url_helper.send("crop_#{@type.downcase}_path",id:@product.id)
    end
      
    

  end

  protected

  def product_params
    params[@type.downcase.to_sym].permit(:title, :subtitle, :description,:category, :display_order, :image, :featured, :visible, prices_attributes: [:amount, :description, :id, :_destroy])
  end

  private
  def remove_featured
    @old_featured = Product.where(featured: true, type: @type).first
    if @old_featured
      @old_featured.featured = false
      @old_featured.save
    end
  end

  def set_type
    @type = Product::CONTROLLER_TO_TYPE[env["action_controller.instance"].class.to_s] 
    instance_variable_set("@#{@type.downcase}", "active")
  end

end
