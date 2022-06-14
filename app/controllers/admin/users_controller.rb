class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all
  end

  def destroy
    User.find_by(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to admin_users_path
  end
  
end
