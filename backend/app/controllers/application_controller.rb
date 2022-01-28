# frozen_string_literal: true

class ApplicationController < ActionController::API
  include LoggerHelper

  rescue_from ActionController::ParameterMissing do
    render json: payload('Param is missing or the value is empty', 500), status: :internal_server_error
  end

  private

  def payload(message, status)
    log_error(message)
    { message: message, status: status }
  end
end
