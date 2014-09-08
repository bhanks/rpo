class PostsController < ApplicationController
  layout :resolve_layout
  

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

  end

  def update

  end

  def destroy

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
