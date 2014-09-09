class AddAboutBoolToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :about, :boolean
    Post.all.map do |post|
      post.about = false
      post.save!
    end
    Post.create(about:true,title:"About",body:"...")
  end
end
