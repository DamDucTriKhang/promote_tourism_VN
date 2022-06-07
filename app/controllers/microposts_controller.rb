class MicropostsController < ApplicationController
  before_action :set_micropost, only: %i[ show edit update destroy ]
  before_action :new_micropost, only: %i[ new create ]

  def index
    @microposts = Micropost.all
  end

  def new
    @micropost = Micropost.new
  end

  def edit; end

  def show; end

  def update
    if @micropost.update(micropost_params)
      flash[:success] = "Micropost updated!"
      redirect_to microposts_url
    else
      flash[:danger] = "Micropost no updated!"
      render :edit
    end
  end

  def create
    @micropost = Micropost.new(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to microposts_url
    else
      # flash là mảng có dạng hash[key;velua], trong trường hợp này key:danger còn velua:"Micropost no created!"
      flash[:danger] = "Micropost no created!"
      render :new
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to microposts_url
  end

  private

  def set_micropost
    @micropost = Micropost.find(params[:id])
  end

  def micropost_params
    params.require(:micropost).permit(:content)
  end

end
