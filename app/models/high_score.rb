class HighScore < ActiveRecord::Base
  belongs_to :game
  validate :name, :presence => true
  validate :score, :presence => true
end
