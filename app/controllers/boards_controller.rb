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
    if @board.save
      redirect_to board_path(@board), notice: '保存できました！'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to board_path(@board), notice: '更新できました！'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def delete
    
  end

  private
  def board_params
    params.require(:board).permit(:title, :content).merge(user_id: current_user.id)
  end
  
end