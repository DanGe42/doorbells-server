class Api::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token

  protected

  # Verifies an authorization token. If the token is bad, tell the client, via
  # JSON, of that fact. If not, set @user to the user found via the token.
  def verify_auth_token
    token = params[:auth_token]
    if token.nil?
      render json_status_response(400, "Authorization token is necessary")
      return
    end

    user = User.find_by_authentication_token(token)
    if user.nil?
      render json_status_response(401, "Bad token")
      return
    end

    @user = user
  end
end
