class TasksController < ApplicationController
  before_action :authenticate_user!

  def show
    @task = Task.find(params[:id])
  end

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    if @task.save
      redirect_to board_path(board), notice: 'タスクを追加しました！'
    else
      flash.now[:error] = 'タスクを追加できませんでした'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to board_task_path(@task), notice: 'タスクを更新しました！'
    else
      flash.now[:error] = 'タスクを更新できませんでした'
      render :edit
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to board_path(id: task.board_id), notice: '削除に成功しました！'
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :limit, :eyecatch).merge(user_id: current_user.id)
  end

end