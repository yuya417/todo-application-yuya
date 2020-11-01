class BoardsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.save!
      redirect_to board_path(@board)
    else
      render :new
    end
  end

  private
  def board_params
    params.require(:board).permit(:title, :content).merge(user_id: current_user.id)
  end
  
end