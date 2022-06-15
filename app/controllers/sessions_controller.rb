class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      if current_user.admin == true
        redirect_to admin_foods_path(user)
      else
        redirect_to user_path(user)
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

	# Returns the current logged-in user (if any).
	def current_user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			unless user&.authenticated?(:remember, cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
	
end
