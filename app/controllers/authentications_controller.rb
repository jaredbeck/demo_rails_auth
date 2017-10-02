class AuthenticationsController < ApplicationController
  def create
    act = Account.find_by(email: creation_params.fetch(:email))
    if act&.authenticate(creation_params.fetch(:password))
      redirect_to(act, notice: "Authentication successful")
    else
      flash[:alert] = "Authentication failed"
      render :new
    end
  end

  def new
  end

  private

  def creation_params
    params.require(:credentials).permit(:email, :password)
  end
end
