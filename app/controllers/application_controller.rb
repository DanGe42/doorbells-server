class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  # Usage:
  #   render json_status_response(400, "message")
  #
  # Examples:
  #   render json_status_response(404, "Not found")
  #   == render :status => 404,
  #             :json => {
  #               status: 404,
  #               msg: "Not found"
  #             }
  #
  #   render json_status_response(404, "Not found", { nyan: "cat" })
  #   == render :status => 404,
  #             :json => {
  #               status: 404,
  #               msg: "Not found",
  #               nyan: "cat"
  #             }
  def json_status_response(status, message, more={})
    json = {
      status: status,
      msg: message
    }
    json.merge!(more)

    return {
      :status => status,
      :json => json
    }
  end
end
