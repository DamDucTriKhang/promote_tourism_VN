class UsersController < ApplicationController
  before_action :set_users, only: %i[ show edit update destroy ]
  before_action :admin_user, only: :destroy

  def index
    @users = User.all
  end

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

  def show; end

  def edit; end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "User updated!"
      redirect_to users_url
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

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
