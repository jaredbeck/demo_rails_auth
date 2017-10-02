class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_authentication

  private

  def require_authentication
    if session[:account_id].nil?
      redirect_to new_authentication_path, alert: "Authentication required"
    end
  end
end
