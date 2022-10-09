# frozen_string_literal: true

# Implements app-wide basic JWT authentication
class ApplicationController < ActionController::API
  rescue_from Exception, with: :exception_handler

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message.to_s }, status: :not_found
    rescue JWT::DecodeError => e
      render json: { errors: e.message.to_s }, status: :bad_request
    end
  end

  def exception_handler(exception)
    case exception
    when Exceptions::BadRequest
      render(json: { message: exception.message }, status: :bad_request) and return
    when Exceptions::NotFound
      render(json: { message: exception.message }, status: :not_found) and return
    else
      render json: { message: exception.message }, status: :internal_server_error and return
    end
  end
end
