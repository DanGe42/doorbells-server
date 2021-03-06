class Api::DevicesController < Api::BaseController
  before_filter :verify_auth_token

  # POST /api/register?id=:id
  # Requires authorization: yes
  def register
    begin
      if @user.register_device(params[:id])
        render json_status_response(200, "Device registered successfully")
      else
        # TODO: can device registration fail in any other way?
        render json_status_response(200, "Device not registered. " <<
                                    "Maybe it's already registered?")
      end
    rescue Redis::CannotConnectError
      render json_status_response(500, "Registration server error. Please " <<
                                  "let me know at dange -at- seas.upenn.edu")
    end
  end

  # POST /api/unregister?id=:id
  # Requires authorization: yes
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
