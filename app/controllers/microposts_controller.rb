class MicropostsController < ApplicationController
  before_action :find_micropost, only: [:edit, :update]
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,only: :destroy

  def index
    @microposts = Micropost.all
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to user_path(current_user)
    else
      @feed_items = current_user.feed.page(params[:page])
      flash[:danger] = "Micropost create fail"
      redirect_to root_path
    end
  end

  def edit
    unless @micropost.user.id == current_user.id
      flash[:danger] = "You do not have access"
      redirect_to root_path
    end
  end

  def update
    if @micropost.update(micropost_params)
      flash[:success] = "micropost updated!"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "Micropost update fail"
      render :edit
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || micropost_path
  end

  private

  def find_micropost
    @micropost = Micropost.find_by(id: params[:id])
  end

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
