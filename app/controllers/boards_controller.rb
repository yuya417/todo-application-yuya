class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update]
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]
  def index
    @boards = Board.all
  end

  def show
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
  end

  def update
    if @board.update(board_params)
      redirect_to board_path(@board), notice: '更新できました！'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy!
    redirect_to root_path, notice: '削除に成功しました'
  end

  private
  def board_params
    params.require(:board).permit(:title, :content).merge(user_id: current_user.id)
  end

  def set_board
    @board = Board.find(params[:id])
  end
  
end