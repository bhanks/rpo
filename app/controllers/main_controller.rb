class MainController < ApplicationController
  def index
    @news = Post.limit(3).order("created_at DESC")
  end
end
