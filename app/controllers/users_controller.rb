class UsersController < ApplicationController
  before_action :set_users, only: %i[ show destroy edit]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User created!"
      redirect_to root_url
    else
      flash[:danger] = "User no create!"
      render :new
    end
  end

  def show
    unless @user.id == current_user.id
      redirect_to root_path
    end
  end

  def edit
    unless @user.id == current_user.id
    else
      redirect_to root_path
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "User updated!"
      redirect_to root_path
    else
      flash[:danger] = "User no update!"
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def set_users
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
