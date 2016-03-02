class UsersController < ApplicationController
  before_action :require_login, only: [:show]
  before_action :require_logout, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:notice] = "You're now registered for Yelpr! Sorry, we don't send confirmation emails yet <|-.-|>"
      redirect_to root_path
    else
      flash[:error] = "Your submissions was invalid. Please fix the highlighted fields."
      render :new
    end
  end

  def show
    @user = User.find params[:id]
  end

private

  def user_params
    params.require(:user).permit :username, :email, :password
  end
end
