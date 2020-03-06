class PlayersController < ApplicationController
  skip_forgery_protection

  def new
  end
  
  def create
    @player = Player.new(player_params)

    @player.save
    redirect_to @player
  end

  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  private
  def player_params
    params.require(:player).permit(:name, :currency)
  end

end
