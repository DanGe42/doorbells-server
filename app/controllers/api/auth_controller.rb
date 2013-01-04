class Api::AuthController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    email    = params[:email]
    password = params[:password]

    if email.nil? or password.nil?
      render json_status_response(400, "Authorization requires an email and password")
      return
    end

    # email.downcase ? Is this correct?
    @user = User.find_by_email(email.downcase)

    if @user.nil?
      logger.info "User with #{email} was not found"
      render json_status_response(401, "Email or password invalid")
      return
    end

    @user.ensure_authentication_token!

    if not @user.valid_password?(password)
      logger.info "User with #{email} did not provide correct password"
      render json_status_response(401, "Email or password invalid")
      return
    end

    # And now...if everything is correct
    render :status => 200,
           :json => {
             status: 200,
             token: @user.authentication_token,
             timestamp: Time.now.to_i
           }
  end

  def destroy
    @user = User.find_by_authentication_token(params[:id])
    if @user.nil?
      render json_status_response(404, "Token not found");
    else
      @user.reset_authentication_token!
      render json_status_response(200, "Token successfully removed")
    end
  end
end
