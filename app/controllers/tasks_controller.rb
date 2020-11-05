class TasksController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    binding.pry
    if @task.save
      redirect_to board_path(board), notice: 'タスクを追加しました！'
    else
      flash.now[:error] = 'タスクを追加できませんでした'
      render :new
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :limit, :eyecatch).merge(user_id: current_user.id)
  end

end