class PostsController < ApplicationController
  layout :resolve_layout
  

  def index
    #redirect_to news_path(Post.order("created_at DESC").limit(1).first.slug)
    @post = Post.order("created_at DESC").limit(1).first
    @previous = Post.where("created_at < ?", @post.created_at).order("created_at DESC").limit(1).first
    @next = Post.where("created_at > ?", @post.created_at).order("created_at ASC").limit(1).first
    @news = "active"
    render :show
  end

  def show
    @post = Post.friendly.find(params[:id])
    @previous = Post.where("created_at < ?", @post.created_at).order("created_at DESC").limit(1).first
    @next = Post.where("created_at > ?", @post.created_at).order("created_at ASC").limit(1).first
  end

  def new
    @post = Post.new
  end 

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice]="Post successfully created"
      redirect_to posts_dashboard_index_path
    else
      render action:"new",layout:"dashboard"
      
    end

  end

  def edit
    @about= false
    @post = Post.friendly.find(params[:id])

  end

  def edit_about
    @about = true
    @post = Post.where(about:true).first
    render action:"edit",layout:"dashboard"
  end

  def update
    unless params[:post][:about]
      @post = Post.friendly.find(params[:id])
      notice = "Post successfuly updated"
    else
      @post = Post.where(about:true).first
      notice = "About page successfuly updated"
    end
    @post.update_attributes(post_params)
    if @post.save
      flash[:notice] = notice
      redirect_to posts_dashboard_index_path
    else
      render action:"edit", layout:"dashboard"
    end

  end

  def destroy
    @post = Post.friendly.find(params[:id])
    @post.destroy
    flash[:notice] = "'#{@post.title}' successfully destroyed." unless @post.errors
    flash[:error] = @post.errors.messages.values.flatten.first
    redirect_to posts_dashboard_index_path

  end

  protected

  def post_params
    params[:post].permit(:title,:body)
  end


  private
  def resolve_layout
    case action_name
    when "new","edit"
      "dashboard"
    end


  end 
end
