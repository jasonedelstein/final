class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    def require_login
      @user = User.find_by(id: session[:user_id])
      
	  if @user.blank?
		redirect_to root_url, notice: "Please log in first."
      end
  
  end
  
    def authorize_user
    if @user.id != params[:id].to_i && session[:admin].to_s != "true"
      redirect_to root_url, notice: "Not permitted."
    end
  end
  
  def require_admin
	if !session[:admin]
		redirect_to :back, notice: "Sorry, only admins may do that."
	end
  end
  
end
