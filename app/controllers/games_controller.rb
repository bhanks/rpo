class GamesController < ProductsController

  def set_high_scores
    @game = Game.includes(:high_scores).find(params[:id])

  end

  def update_high_scores

  end

  protected

  def product_params
    params[:game].permit(high_scores_attributes: [:score, :name, :id, :_destroy])
  end

end
