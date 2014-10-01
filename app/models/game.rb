class Game < Product
  has_many :high_scores
  accepts_nested_attributes_for :high_scores, allow_destroy:true, reject_if: proc {|attr| attr[:score].blank? || attr[:name].blank?}


  CATEGORIES = {
    1 => "Cabinets",
    2 => "Pinball"
  }

end
