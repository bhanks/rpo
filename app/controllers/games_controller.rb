class GamesController < ProductsController

  def set_high_scores
    @game = Game.includes(:high_scores).find(params[:id])

    empty = 10-@game.high_scores.length
    empty.times do 
      @game.high_scores.build
    end
  end

  def update_scores
    @game = Game.find(params[:id])
    @game.update_attributes(product_params)
    if @game.save
      redirect_to games_dashboard_index_path
    end
  end

  protected

  def product_params
    params[:game].permit(high_scores_attributes: [:score, :name, :id, :_destroy])
    super
  end

end
