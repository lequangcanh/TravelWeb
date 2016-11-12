class Admin::UsersController < Admin::BaseController

  def index
    @users = User.paginate(page: params[:page])
    if params[:search]
      @users = User.search(params[:search]).paginate(page: params[:page])
    else
      @users = User.paginate(page: params[:page])
    end
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
      flash[:success] = "User is updated successfull"
      redirect_to admin_user_url(@user)
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User is deleted successfully"
    redirect_to admin_users_url
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:success] = "New user is created successfully"
      redirect_to admin_user_path(@user)
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, 
        :password, :password_confirmation, :is_admin)
  end
end
