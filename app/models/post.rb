class Post < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, :use => :slugged

  validates :title, presence:true
  validates :body, presence:true
end
