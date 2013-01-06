class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  # Usage:
  #   render json_status_response(400, "message")
  def json_status_response(status, message)
    return {
      :status => status,
      :json => {
        status: status,
        msg: message,
      }
    }
  end
end
