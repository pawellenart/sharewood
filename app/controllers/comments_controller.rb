class CommentsController < ApplicationController
  before_filter :load_project
  
  def create
    @comment = @project.comments.new(params[:comment])
    @comment.user = current_user
    
    if @comment.save
      redirect_to @project, :notice => 'Comment has been added'
    else
      redirect_to @project, :alert => 'Unable to add a comment'
    end
  end
  
  def destroy
    @comment = @project.comments.find(params[:id])
    @comment.destroy
    
    redirect_to @project, :notice => 'Comment has been deleted'
  end
  
  private
  
  def load_project
    @project = Project.find(params[:project_id])
  end
end