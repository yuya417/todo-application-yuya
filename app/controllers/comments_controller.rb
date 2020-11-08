class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    task = Task.find(params[:task_id])
    @comment = task.comments.build
  end

end