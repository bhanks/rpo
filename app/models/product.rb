class Product < ActiveRecord::Base
  has_many :prices, dependent: :destroy
  accepts_nested_attributes_for :prices, allow_destroy:true, reject_if: proc {|attr| attr[:amount].blank?}
  validate :featured_must_be_visible
  validate :feature_must_have_image
  validates :title, presence:true
  before_destroy :remove_image
  before_destroy :prevent_feature_delete
  mount_uploader :image, ImageUploader
  attr_accessor :crop_x, :crop_y, :crop_h, :crop_w

  CONTROLLER_TO_TYPE = {
    "GamesController"=> "Game",
    "BeersController"=> "Beer",
    "PizzasController"=> "Pizza",
    "ProductsController"=>"Product"
  }

  def featured_must_be_visible
    if featured && !visible
      errors.add(:visible, ": featured product must be visible")
    end
  end
  
  def feature_must_have_image
    if featured && !self.image.present?
      errors.add(:image, ": featured product must have an image")
    end
  end

  def remove_image
    self.remove_image!
  end

  protected

  def prevent_feature_delete
    errors.add(:feature, 'Featured product must exist.') if self.featured
    !self.featured
  end

end
