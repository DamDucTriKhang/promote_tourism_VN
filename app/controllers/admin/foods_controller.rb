class Admin::FoodsController < Admin::BaseController
  before_action :food_params, only: [:create]
  before_action :find_food, only: [:show, :edit, :update]
  
  def index
    @foods = Food.all.page(params[:page]).per(5)
  end

  def show; end
  
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

  def edit; end

  def update
    if @food.update(food_params)
      flash[:success] = "food updated"
      redirect_to admin_foods_path
    # Handle a successful update.
    else
      render :edit
    end
  end

  def destroy
    Food.find(params[:id]).destroy
    flash[:success] = "Food deleted"
    redirect_to admin_foods_path
  end

  private

  def find_food
    @food = Food.find_by(id: params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :food_content, :image, :category_id)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

end
