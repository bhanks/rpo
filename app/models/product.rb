class Product < ActiveRecord::Base
  has_many :prices, dependent: :destroy
  accepts_nested_attributes_for :prices, allow_destroy:true, reject_if: proc {|attr| attr[:amount].blank?}
  validate :featured_must_be_visible
  validates :title, presence:true
  before_destroy :remove_image
  mount_uploader :image

  def featured_must_be_visible
    if featured && !visible
      errors.add(:visible, ": featured product must be visible")
    end
  end

  def remove_image
    self.remove_image!
  end
end
