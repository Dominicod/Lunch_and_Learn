# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActionController::ParameterMissing, with: :render_bad_request
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from IncorrectEmailException, with: :render_bad_request


  def render_unprocessable_entity(exception)
    render json: unprocessable_entity(exception), status: :unprocessable_entity
  end

  def render_bad_request(exception)
    render json: bad_request(exception), status: :bad_request
  end

  def render_not_found(exception)
    render json: not_found(exception), status: :not_found
  end

  private

  def not_found(exception)
    error_message({ code: 404, status: Rack::Utils::HTTP_STATUS_CODES[404], message: exception })
  end

  def bad_request(exception)
    error_message({ code: 400, status: Rack::Utils::HTTP_STATUS_CODES[400], message: exception })
  end

  def unprocessable_entity(exception)
    errors = exception.message.split(':')[1].split(',').map(&:strip)
    error_message({ code: 422, status: Rack::Utils::HTTP_STATUS_CODES[422], message: errors })
  end

  def error_message(error)
    ErrorSerializer.new(
      Error.new({ code: error[:code], status: error[:status], message: error[:message] })
    ).serializable_json
  end

  def random_country
    return unless params[:country].nil?

    params[:country] = CountryFacade.random_country.name
  end
end
