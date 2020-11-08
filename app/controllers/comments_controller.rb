class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    task = Task.find(params[:task_id])
    @comment = task.comments.build
  end

  def create
    task = Task.find(params[:task_id])
    @comment = task.comments.build(comment_params)
    if @comment.save
      redirect_to board_task_path(task), notice: 'コメントを追加しました！'
    else
      flash.now[:error] = 'コメントを投稿できませんでした'
      render :new
    end
  end

  private
  def comment_params
    
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end

end