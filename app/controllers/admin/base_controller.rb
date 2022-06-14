class Admin::BaseController < ApplicationController
	before_action :check_admin

	def check_admin
    if current_user.present?
			unless current_user.admin?
				flash[:danger] = "User does not have permission"
        redirect_to root_path
			end
    else
      flash[:danger] = "Please login"
      redirect_to new_user_path
    end
  end

end
