class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :session_id
  before_action :header_vars, if: :signed_in?

  def session_id
    token = Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64)

    if current_user
      if cookies[:session_id].present?
        list = List.find_by(session_id: cookies[:session_id])

        if list
          current_user.update_attributes(current_session_id: list.session_id)
        else
          list = List.find_by(session_id: current_user.current_session_id)

          unless list
            current_user.update_attributes(current_session_id: token)
          end
        end

        cookies.delete(:session_id)
      else
        list = List.find_by(session_id: current_user.current_session_id)

        unless list
          current_user.update_attributes(current_session_id: token)
        end
      end

    else
      cookies[:session_id] ||= token
    end
  end

  def header_vars
    list = List.find_by(session_id: @session_id)

    list.codes_list if list
  end
end
