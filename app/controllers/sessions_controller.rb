class SessionsController < ApplicationController
  before_action :require_logout, except: [:destroy]

  def create
    user = User.find_by email: params[:email]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You've successfully logged in as #{user.username}."
      redirect_to root_path
    else
      flash.now[:error] = 'Your login information was incorrect. Please verify your submission and try agian.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Successfully logged out.'
    redirect_to root_path
  end
end
