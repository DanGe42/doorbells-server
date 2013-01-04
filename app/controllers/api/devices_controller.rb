class Api::DevicesController < Api::BaseController
  before_filter :verify_auth_token

  def register
    begin
      if @user.register_device(params[:id])
        render json_status_response(200, "Device registered successfully")
      else
        render json_status_response(400, "Device not registered. " <<
                                    "Maybe it's already registered?")
      end
    rescue Redis::CannotConnectError
      render json_status_response(500, "Registration server error. Please " <<
                                  "let me know at dange -at- seas.upenn.edu")
    end
  end

  def unregister
    begin
      if @user.unregister_device(params[:id])
        render json_status_response(200, "Device unregistered successfully")
      else
        render json_status_response(404, "Device not found")
      end
    rescue Redis::CannotConnectError
      render json_status_response(500, "Registration server error. Please " <<
                                  "let me know at dange -at- seas.upenn.edu")
    end
  end
end
