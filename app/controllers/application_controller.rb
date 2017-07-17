class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :session_id

  def session_id
    unless cookies[:session_id]
      cookies[:session_id] = Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64)
    end
  end
end
