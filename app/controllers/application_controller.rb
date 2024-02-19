class ApplicationController < ActionController::Base
  before_action :authenticate_guest

  def authenticate_guest
    cookies.delete :guest_token

    if cookies[:guest_token]
      @guest = Guest.find_by_token(cookies[:guest_token])
    else
      guest_token = SecureRandom.uuid
      cookies[:guest_token] = guest_token
      @guest = Guest.create!(token: guest_token)
    end
  end

    rescue_from CanCan::AccessDenied do |exception|
        respond_to do |format|
          format.json { head :forbidden }
          format.html { redirect_to root_path, notice: exception.message }
        end
      end
end
