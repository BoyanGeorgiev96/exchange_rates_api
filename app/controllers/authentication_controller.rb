# frozen_string_literal: true

# Authenticate User using a JWT token, render unauthorized if user cannot be authenticated
class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 1.hour.to_i
      render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M') }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
