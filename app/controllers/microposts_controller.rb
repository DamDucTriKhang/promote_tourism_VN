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
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render :home
    end
  end

  def edit
  end

  def update
    user = User.find_by_id(params[:micropost][:user_id])
    if @micropost.update(micropost_params)
      flash[:success] = "micropost updated!"
      redirect_to user_path(user)
    else
      flash[:danger] = "micropost no update!"
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
