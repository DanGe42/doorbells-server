class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  # Usage:
  #   render json_status_response(400, "message")
  def json_status_response(status, message, timestamp=Time.now)
    return {
      :status => status,
      :json => {
        status: status,
        msg: message,
        timestamp: timestamp.to_i
      }
    }
  end
end
