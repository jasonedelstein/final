class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]
  before_action :authorize_user, only: [:show, :edit, :update]

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

  def index
    @users = User.all
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
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]

    if @user.password.present? && @user.password == params[:password_confirmation]
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
  
  def sort_column
    Item.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end