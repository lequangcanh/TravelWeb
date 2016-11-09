class Admin::UsersController < ApplicationController
  layout 'admin/layouts/admin_panel'

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Update successfull"
      redirect_to admin_user_url(@user)
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to admin_users_url
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
