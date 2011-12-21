class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_after_sign_up?

  # GET /projects
  # GET /projects.xml
  def index
    if current_user.admin?
      @projects = Project.all
    else
      @projects = User.find(current_user.id).projects
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    unless @project.user_ids.include?(current_user.id) || current_user.admin?
      redirect_to projects_url, :alert => "You are not allowed to do that" and return
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @project }
      end
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    redirect_to projects_url, :alert => "You are not allowed to do that" and return unless current_user.admin?

    @project = Project.new
    @users = User.where(:admin => false)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    redirect_to projects_url, :alert => "You are not allowed to do that" and return unless current_user.admin?

    @project = Project.find(params[:id])
    @users = User.where(:admin => false)
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    params[:project][:user_ids] ||= []

    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end

  private

  def user_after_sign_up?
    if current_user.profile.nil?
      redirect_to edit_user_path(current_user), :alert => 'You have to fill out your details first'
    else
      true
    end
  end
end
