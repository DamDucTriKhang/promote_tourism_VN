class AdminsController < ApplicationController

  def index
    @users = User.all
  end

  def destroy
    @user = User
  end
  
  def show
    @user = User.find(params[:id])
    @foods = @user.foods.paginate(page: params[:page])
  end

end
