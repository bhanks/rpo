class RemoveAboutFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :about
    Post.destroy_all
  end
end
