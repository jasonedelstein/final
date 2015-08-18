class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]
  before_action :authorize_user, only: [:show, :edit, :update]
  before_action :require_admin, only: [:index]

  autocomplete :user, :email
  
  def require_login
    @user = User.find_by(id: session[:user_id])
    if @user.blank?
      redirect_to root_url, notice: "Please log in first."
    end
  end

  def authorize_user
    if @user.id != params[:id].to_i
      redirect_to root_url, notice: "Nice try!"
    end
  end
  
  def require_admin
	if !session[:admin]
		redirect_to root_url, notice: "Sorry, only admins may do that."
	end
  end

  def index
    @users = User.all
	@users = @users.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.first_name = params[:first_name]
    @user.first_name = params[:last_name]
	@user.email = params[:email]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]

    if @user.save
      flash[:notice] = "Thanks for signing up!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user.first_name = params[:first_name]
	@user.last_name = params[:last_name]
    
	if !params[:password].nil? && params[:password] == params[:password_confirmation]
		@user.password = params[:password]

    if @user.save
        flash[:notice] = "Account updated successfully."
        redirect_to user_url(@user.id)
      else
        render 'edit'
      end
    else
      @user.errors.add(:password, "does not match")
      render 'edit'
    end
  end
  
  def promote
    @user = User.find_by(:id => params["id"])
	
	if !@user.admin
		@user.admin = true
		@user.save
		flash[:notice] = "Account #{@user.fullname} promoted to admin successfully."
		redirect_to '/users/'
	else
		@user.admin = false
		@user.save
		flash[:notice] = "Account #{@user.fullname} demoted from admin successfully."
		redirect_to '/users/'
	end
  end

end