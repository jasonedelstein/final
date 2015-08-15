class SessionsController < ApplicationController

  def new

  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Logout complete!"
  end
  
  def create
    user = User.find_by_email(params["email"])

    if user
      if user.authenticate(params["password"])
        session[:user_id] = user.id
        flash[:notice] = "Welcome back, #{user.fullname}!"
        redirect_to root_url
      else
	    flash[:notice] = "Bad login, please try again!"
        render 'new'
      end
    else
      render 'new'
    end
  end

 end