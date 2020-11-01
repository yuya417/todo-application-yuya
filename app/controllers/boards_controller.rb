class BoardsController < ApplicationController
  
  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def create
    @board.save
  end
  
end