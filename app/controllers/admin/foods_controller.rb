class Admin::FoodsController < ApplicationController
  # before_action :food_params, only: [:create, :destroy]
  
  def index
    @foods = Food.all
  end

  def show
    @food = Food.find_by(params[:id])
  end
  
  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.image.attach(params[:food][:image])
    if @food.save
      flash[:success] = "Food created!"
      redirect_to admin_foods_path
    else
      flash[:danger] = "Food no created!"
      render :new
    end
  end

  def edit
    @food = Food.find_by(params[:id])
  end

  def update
    @food = Food.find_by(params[:id])
    if @food.update(food_params)
      flash[:success] = "Profile updated"
      redirect_to admin_food_path
    # Handle a successful update.
    else
      render 'edit'
    end
  end

  def destroy
    Food.find(params[:id]).destroy
    flash[:success] = "Food deleted"
    redirect_to admin_foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :food_content, :image, :category_id)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_admin
    @user = User.find_(params[:id])
    redirect_to(root_url) unless current_admin?(@user)
  end
end
