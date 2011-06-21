class DocumentsController < ApplicationController
  before_filter :load_project
  
  def create
    @document = @project.documents.new(params[:document])
    @document.user = current_user
    
    if @document.save
      redirect_to @project, :notice => 'Document has been added'
    else
      redirect_to @project, :alert => 'Unable to add a document'
    end
  end
  
  def destroy
    @document = @project.comments.find(params[:id])
    @document.destroy
    
    redirect_to @project, :notice => 'Document has been deleted'
  end
  
  private
  
  def load_project
    @project = Project.find(params[:project_id])
  end
end