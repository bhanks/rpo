class Product < ActiveRecord::Base
  has_many :prices, dependent: :destroy
  accepts_nested_attributes_for :prices, allow_destroy:true, reject_if: proc {|attr| attr[:amount].blank?}
  validate :featured_must_be_visible
  validates :title, presence:true
  before_destroy :remove_image
  before_destroy :prevent_feature_delete
  mount_uploader :image

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

  def remove_image
    self.remove_image!
  end

  protected

  def prevent_feature_delete
    errors.add(:feature, 'Featured product must exist.') if self.featured
    !self.featured
  end

end
