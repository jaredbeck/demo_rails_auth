class AuthenticationsController < ApplicationController
  skip_before_action :require_authentication

  def create
    act = Account.find_by(email: creation_params.fetch(:email))
    if act&.authenticate(creation_params.fetch(:password))
      session[:account_id] = act.id
      redirect_to(act, notice: "Authentication successful")
    else
      flash[:alert] = "Authentication failed"
      render :new
    end
  end

  def destroy
    session[:account_id] = nil
    flash[:notice] = "You are signed out. See you next time!"
    render :new
  end

  def new
  end

  private

  def creation_params
    params.require(:credentials).permit(:email, :password)
  end
end
