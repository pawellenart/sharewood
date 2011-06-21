class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    redirect_to(user_path(current_user), :alert => 'You are not allowed to do that') and return unless current_user.admin?
    
    @users = User.all
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # GET /users/1
  def show    
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def edit
    @user = User.find(params[:id])
    redirect_to(user_path(current_user), :alert => 'You are not allowed to do that') and return unless @user == current_user || current_user.admin?
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end
